class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :task
  attr_accessible :body
  validates :body, presence: :true
end
