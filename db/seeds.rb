# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Project.destroy_all
Membership.destroy_all
Task.destroy_all
Comment.destroy_all

@num = (1..100).to_a.shuffle
@num1 = (1..100).to_a.shuffle
@num2 = (1..100).to_a.shuffle
@num3 = (1..100).to_a.shuffle
@num4 = (1..100).to_a.shuffle
@num5 = (1..100).to_a.shuffle

100.times do
  User.create!(
    first_name: "First",
    last_name: "Last",
    email: "email#{@num.pop.to_s}@email.com",
    password: "password"
  )
end

100.times do
  Project.create!(
  name: "project#{@num1.pop.to_s}"
  )
end

100.times do
  Membership.create!(
  project_id: nil,
  user_id: @num2.pop
  )
end

@deleted_num = (101..201).to_a.shuffle
@deleted_num1 = (101..201).to_a.shuffle
@deleted_num2 = (101..201).to_a.shuffle
@deleted_num3 = (101..201).to_a.shuffle
@deleted_num4 = (101..201).to_a.shuffle

100.times do
  Membership.create!(project_id: @deleted_num3.pop, user_id: rand(100)+1)
  Membership.create!(project_id: rand(100)+1, user_id: @deleted_num4.pop)
end

100.times do
 Task.create!(description: "Task#{@num5.pop.to_s}", project_id: @deleted_num.pop)
  Task.create!(description: "Task#{@deleted_num1.pop.to_s}", project_id: nil)
end

100.times do
  Comment.create!(user_id: 5, task_id: @deleted_num2.pop, body: "great!")
  Comment.create!(user_id: 7, task_id: nil, body: "even greater!")
end

@user = User.create!(first_name: "Amy", last_name: "B", email: "amy@email.com", password: "password")

Comment.create!(user_id: @user.id, task_id: 8, body: "the best!")

@user.delete
