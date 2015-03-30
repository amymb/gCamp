def sign_in_user
  visit root_path
  @user = create_user
  click_link 'Sign in'
  fill_in :email, with: 'loosey_goosey@email.com'
  fill_in :password, with: 'meh'
  click_on 'Sign In'
end


def sign_in_user_2
  visit root_path
  click_link 'Sign in'
  fill_in :email, with: 'piggy@email.com'
  fill_in :password, with: 'verysafe'
  click_button 'Sign In'
end
