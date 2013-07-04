class Group < ActiveRecord::Base
  attr_accessible :title

  has_many :memberships
  has_many :members, :through => :memberships, :source => :user
end
