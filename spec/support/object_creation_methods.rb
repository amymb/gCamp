
def create_project
  Project.create!(
    name: "Test Project"
  )
end

def create_task
  project = create_project
  Task.create!(description: "baaaa", project_id: project.id)
end


def create_membership
  @project = create_project
  user = create_user
  Membership.create!(
    project_id: @project.id,
    user_id: user.id,
    role: 'Member'
  )
end

def create_user
  User.create!(
  first_name: 'Goosey', last_name: 'Loosey', email: 'loosegoose@email.com',
  password: 'meh', password_confirmation: 'meh'
  )
end
