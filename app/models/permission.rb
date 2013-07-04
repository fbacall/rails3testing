class Permission < ActiveRecord::Base
  attr_accessible :privilege, :for, :for_type, :for_id
  belongs_to :policy
  belongs_to :for, :polymorphic => true

  validates :for_type, :inclusion => ['User', 'Group', 'Public']
  validates :for_id, :presence => true, :unless => "for_type == 'Public'"
end
