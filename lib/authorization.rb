# TODO: Find better, Rails 3 way of doing this

module Authorization

  PRIVILEGE_LEVELS = {
    :none => 0,
    :view => 1,
    :download => 2,
    :edit => 3,
    :manage => 4
  }.freeze

  LEVEL_PRIVILEGE = PRIVILEGE_LEVELS.invert.freeze

  def self.privilege_level(privilege)
    PRIVILEGE_LEVELS[privilege]
  end

  def self.level_privilege(level)
    LEVEL_PRIVILEGE[level]
  end

  def self.included(base)
    base.class_eval do
      # Find only things that the given user has the given privilege for
      # Also loads permissions into memory.
      scope :with_privilege, lambda { |user, privilege|
        includes(:policy => :permissions).
        where("permissions.privilege >= ? AND (
                (permissions.for_type = 'User' AND permissions.for_id = ?) OR
                (permissions.for_type = 'Group' AND permissions.for_id IN (?)) OR
                (permissions.for_type = 'Public')
               )", Authorization.privilege_level(privilege), user, user ? user.groups : [])
      }
    end
  end

  # Check if the given user has the given privilege.
  # Doesn't need to do additional queries if operating on a #with_privilege scope.
  def can?(user, privilege)
    perms = self.policy.permissions.select do |p|
      user && (p.for == user ||  user.groups.include?(p.for)) ||
          p.for_type == 'Public'
    end

    perms.empty? ? false : perms.max_by(&:privilege).privilege >= Authorization.privilege_level(privilege)
  end

end