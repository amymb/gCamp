def sign_in_user
  user = User.new(first_name: 'Piglet', last_name: 'Smith', email: 'piggy@email.com', password: 'verysafe', password_confirmation: 'verysafe')
  user.save!
  visit root_path
  click_link 'Sign in'
  fill_in :email, with: 'piggy@email.com'
  fill_in :password, with: 'verysafe'
  click_button 'Sign In'
end
