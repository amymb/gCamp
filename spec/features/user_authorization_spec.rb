require 'rails_helper'

feature "user authorization" do

  scenario "user can sign up" do
    visit root_path
    click_link "Sign up"
    click_button "Sign Up"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Email can't be blank"

    fill_in "First name", with: "Pete"
    fill_in "Last name", with: "Repeat"
    fill_in "Email", with: "pete@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "rabbit"
    click_button "Sign Up"

    expect(page).to have_content "Password confirmation doesn't match Password"


    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"

    expect(page).to have_content "You have successfully signed up!"
    expect(page).to have_content "Your life, organized"
  end

  scenario "user can sign in" do
    visit root_path
    funuser = User.new(first_name: "Little Bo", last_name: "Peep", email: "little@email.com", password: "12345", password_confirmation: "12345")
    funuser.save!
    click_link "Sign in"
    click_button "Sign In"
    expect(page).to have_content "Email / Password combination is invalid"
    fill_in "Email", with: "little@email.com"
    fill_in "Password", with: "12345"
    click_button "Sign In"

    expect(page).to have_content "You have successfully signed in"
    expect(page).to have_content "Little Bo Peep"

    click_link "Little Bo Peep"
    expect(page).to have_content "little@email.com"
    expect(page).to have_content "Projects"
    expect(page).to have_content "Tasks"
  end

  scenario "user can sign out" do
    visit root_path
    sign_in_user
    click_link "Sign Out"
    expect(page).to have_content "You have successfully signed out"
    expect(page).to have_content "Your life, organized"
  end

end
