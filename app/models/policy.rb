class Policy < ActiveRecord::Base

  attr_accessible :privileges, :title, :permissions_attributes
  has_many :permissions, :autosave => true
  accepts_nested_attributes_for :permissions, :allow_destroy => true
  validate :has_one_public_permission
  validate :has_manage_permission

  def privileges=(hash)
    # Mark old permissions to be destroyed when the policy is saved
    permissions.each { |p| p.mark_for_destruction }

    p hash

    hash.each do |subject, privilege|
      if subject == 'public'
        permissions.build(:for_type => 'Public', :privilege => privilege)
      else
        permissions.build(:for => subject, :privilege => privilege)
      end
    end
  end

  private

  def has_one_public_permission
    unless permissions.select { |p| !p.marked_for_destruction? && p.public? }.count == 1
      errors.add(:permissions, 'must specify public privilege level.')
      false
    end
  end

  def has_manage_permission
    unless permissions.select { |p| !p.marked_for_destruction? && p.privilege == Authorization.privilege_level(:manage)}.count > 0
      errors.add(:permissions, 'must specify at least one user or group with management privileges.')
      false
    end
  end
end
