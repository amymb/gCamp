
def create_project
  Project.create!(
    name: "Test Project"
  )
end

def create_task
  project = create_project
  Task.create!(description: "baaaa", project_id: project.id)
end



def create_user
  User.create!(
  first_name: 'Goosey', last_name: 'Loosey', email: 'loosegoose@email.com',
  password: 'meh', password_confirmation: 'meh'
  )
end

def create_user_2
  User.create!(
  first_name: 'Piglet',
  last_name: 'Smith',
  email: 'piggy@email.com',
  password: 'verysafe',
   password_confirmation: 'verysafe')
end
