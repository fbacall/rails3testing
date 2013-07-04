class User < ActiveRecord::Base

  attr_accessible :email, :name, :username, :password, :password_confirmation

  has_secure_password
  validates :password, :presence => { :on => :create }
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^[^@\s]+@[^@\s]/}
  validates :name, :presence => true

  has_and_belongs_to_many :roles
  has_many :articles
  has_many :memberships
  has_many :groups, :through => :memberships

  def can?(action, object)
    if (roles = Permissions.roles(object, action))
      self.roles.where(:name => roles).exists?
    else
      false
    end
  end
end
