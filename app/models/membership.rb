class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  ROLE = ['Member', 'Owner']
  validates_inclusion_of :role, :in => ROLE
end
