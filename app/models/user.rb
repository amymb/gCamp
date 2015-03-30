class User < ActiveRecord::Base
  has_secure_password
  #before_action :check_credentials

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :admin
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :memberships, :dependent => :destroy
  has_many :projects, through: :memberships
  has_many :comments, :dependent => :nullify


  def full_name
    "#{first_name} #{last_name}"
  end

  # def check_credentials
  #   if self.admin
  #     attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :admin
  #   else
  #     attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  #   end
  # end


end
