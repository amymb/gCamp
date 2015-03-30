class Task < ActiveRecord::Base
  attr_accessible :description, :due_date, :completed
  validates :description, presence: true
  belongs_to :project
  has_many :comments, :dependent => :destroy
end
