class Workflow < ActiveRecord::Base
  attr_accessible :policy_attributes, :description, :title, :author, :document

  include Authorization

  belongs_to :author, :class_name => 'User'
  belongs_to :policy
  has_attached_file :document


  accepts_nested_attributes_for :policy
end
