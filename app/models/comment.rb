class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :task
  attr_accessible :body, :user_id, :task_id
  validates :body, presence: :true
end
