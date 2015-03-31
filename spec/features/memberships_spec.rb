require 'rails_helper'

feature 'manage memberships' do
  scenario 'memberships page shows all memberships' do
    user_2 = create_user_2
    sign_in_user_2
    membership = create_membership({user_id: user_2.id})
    visit projects_path
    expect(page).to have_content "Test Project"
    within(:table) do
      click_on 'Test Project'
    end
    click_on '1 Member'

    expect(page).to have_content "Goosey"

  end

  scenario 'memberships page has breadcrumb' do
    user_2 = create_user_2
    membership = create_membership({user_id: user_2.id})
    sign_in_user_2
    visit project_memberships_path(membership.project)
    expect(page).to have_content "Projects Test Project Memberships"
  end

  scenario 'user can choose member from collection, select role, and create new member' do
    project = create_project
    user_2 = create_user_2
    sign_in_user_2

    visit project_memberships_path(project.id)
    click_on "Add New Member"

    expect(page).to have_content "User can't be blank"

    select user_2.full_name, from: 'membership_user_id'
    select "Owner", from: 'membership_role'
    click_on "Add New Member"
    expect(page).to have_content "Piglet Smith was successfully added"

    select user_2.full_name, from: 'membership_user_id'
    click_on "Add New Member"
    expect(page).to have_content "User has already been added to this project"
  end


  scenario 'user can delete member from index page' do
    project = create_project
    user2 = create_user_2
    sign_in_user

    visit project_memberships_path(project)
    expect(page).to have_content "Manage Members"

    select user2.full_name, from: 'membership_user_id'
    select "Owner", from: 'membership_role'
    click_on "Add New Member"


    select @user.full_name, from: 'membership_user_id'
    select "Owner", from: 'membership_role', match: :first

    click_on "Add New Member"


    find(".glyphicon", match: :first).click

    expect(page).to have_content "Piglet Smith was successfully removed"

    expect(page).to have_content "You are the last owner"

  end



end
