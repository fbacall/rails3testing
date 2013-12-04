class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :email, :name, :username, :password, :password_confirmation, :avatar

  has_secure_password
  validates :password, :presence => { :on => :create }
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^[^@\s]+@[^@\s]/}
  validates :name, :presence => true

  has_and_belongs_to_many :roles
  has_many :articles
  has_many :memberships
  has_many :groups, :through => :memberships
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "64x64>" },
                    :default_url => "/images/:style/missing.png"

  def can?(action, object)
    if (roles = Permissions.roles(object, action))
      self.roles.where(:name => roles).exists?
    else
      false
    end
  end
end
