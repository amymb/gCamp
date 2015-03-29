class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :memberships, :dependent => :destroy
  has_many :projects, through: :memberships
  has_many :comments, :dependent => :nullify


  def full_name
    "#{first_name} #{last_name}"
  end

end
