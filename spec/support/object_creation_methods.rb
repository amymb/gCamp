def sign_in_user
  user = User.new(first_name: 'Piglet', last_name: 'Smith', email: 'piggy@email.com', password: 'verysafe', password_confirmation: 'verysafe')
  user.save!
  visit root_path
  click_link 'Sign in'
  fill_in :email, with: 'piggy@email.com'
  fill_in :password, with: 'verysafe'
  click_button 'Sign In'
end

def create_project
  Project.create!(
    name: "Test Project"
  )
end


def create_membership
  @project = create_project
  user = create_user
  Membership.create!(
    project_id: @project.id,
    user_id: user.id
  )
end

def create_user
  User.create!(
  first_name: 'Goosey', last_name: 'Loosey', email: 'loosegoose@email.com',
  password: 'meh', password_confirmation: 'meh'
  )
end
