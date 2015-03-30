
def create_project
  Project.create!(
    name: "Test Project"
  )
end

def create_task(overrides = {})
  project = create_project
  defaults = {
    description: "baaaa",
    project_id: project.id
  }
  Task.create!(defaults.merge(overrides))
end



def create_user(overrides = {})
  defaults = {
  first_name: 'Goosey', last_name: 'Loosey', email: 'loosegoose@email.com',
  password: 'meh', password_confirmation: 'meh', admin: true
  }
  User.create!(defaults.merge(overrides))
end

def create_user_2(overrides = {})
  defaults = {
  first_name: 'Piglet',
  last_name: 'Smith',
  email: 'piggy@email.com',
  password: 'verysafe',
  password_confirmation: 'verysafe',
  admin: true
  }
  User.create!(defaults.merge(overrides))
end

def create_membership
  project = create_project
  user = create_user
  Membership.create!(project_id: project.id, user_id: user.id, role: "Member")
end
