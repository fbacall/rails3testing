class Policy < ActiveRecord::Base
  attr_accessible :privileges, :title, :permissions_attributes
  has_many :permissions, :autosave => true
  accepts_nested_attributes_for :permissions, :allow_destroy => true

  def privileges=(hash)
    # Mark old permissions to be destroyed when the policy is saved
    permissions.each { |p| p.mark_for_destruction }

    hash[:privileges].each do |subject, privilege|
      permissions.build(:for => subject, :privilege => privilege)
    end

    permissions.build(:for_type => 'Public', :privilege => hash[:public_privilege] || 0)
  end
end
