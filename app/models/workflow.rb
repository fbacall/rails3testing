class Workflow < ActiveRecord::Base
  attr_accessible :content_blob_attributes, :policy_attributes, :description, :title

  include Authorization

  belongs_to :content_blob
  belongs_to :author, :class_name => 'User'
  belongs_to :policy

  accepts_nested_attributes_for :content_blob, :policy
end
