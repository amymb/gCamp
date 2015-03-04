require 'rails_helper'

feature 'user can manage users' do
  scenario 'user can see users displayed on index page' do
    testuser1 = User.new(first_name: 'Test', last_name: 'User1', email: 'TestUser1@email.com', password:'password', password_confirmation: 'password')
    testuser1.save!
    testuser2 = User.new(first_name: 'Test', last_name: 'User2', email: 'TestUser2@email.com', password: 'password', password_confirmation: 'password')
    testuser2.save!
    sign_in_user
    visit users_path
    expect(page).to have_content 'User1@email.com'
    expect(page).to have_content 'User2@email.com'
  end

  scenario 'user can create users' do
    sign_in_user
    visit users_path
    click_link "New User"
    click_button "Create User"
    expect(page).to have_content '4 errors prohibited this form from being saved'
    expect(page).to have_content 'First name can\'t be blank'
    expect(page).to have_content 'Last name can\'t be blank'
    expect(page).to have_content 'Email can\'t be blank'

#    fill_in :first_name, with: "Boo"
#    fill_in :last_name, with: "Radley"
#    fill_in :email, with: "boo@email.com"
#    click_link "Create User"

#    expect(page).to have_content 'User successfully created'
#    expect(page).to have_content 'boo@email.com'

  end

  scenario 'user can see users' do
    testuser2 = User.new(first_name: 'Test', last_name: 'User2', email: 'TestUser2@email.com', password: 'password', password_confirmation: 'password')
    testuser2.save!
    sign_in_user
    visit users_path
    click_link "Test User2"
    expect(page).to have_content "TestUser2@email.com"
  end

  scenario 'user can edit users' do
    testuser1 = User.new(first_name: 'Test', last_name: 'User1', email: 'TestUser1@email.com', password:'password', password_confirmation: 'password')
    testuser1.save!
    sign_in_user
    visit users_path
    click_link "Test User1"
    click_link "Edit"
    fill_in "Last name", with: "User123"
    click_button "Update user"
    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content "Test User123"
  end

  scenario 'user can delete users' do
    testuser = User.new(first_name: 'Test', last_name: 'User', email: 'TestUser@email.com', password: 'password')
    testuser.save!
    sign_in_user
    visit users_path
    click_link "Test User"
    click_link "Edit"
    click_link "Delete"
    expect(page).to have_content "User was successfully deleted"
    expect(page).to_not have_content "Test User"
  end
end
