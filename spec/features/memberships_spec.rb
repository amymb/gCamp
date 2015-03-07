require 'rails_helper'

feature 'manage memberships' do
  scenario 'memberships page shows all memberships' do
    membership = create_membership
    sign_in_user
    visit projects_path
    click_on 'Test Project'
    click_on '1 Member'

    expect(page).to have_content "Piglet"

  end

  scenario 'memberships page has breadcrumb' do
    membership = create_membership
    sign_in_user
    visit project_memberships_path(@project)
    expect(page).to have_content "Projects Test Project Memberships"
  end

  scenario 'user can choose member from collection, select role, and create new member' do
    project = create_project
    user = create_user
    sign_in_user
    visit project_memberships_path(project)
    click_on "Add New Member"

    expect(page).to have_content "User can't be blank"

    select user.full_name, from: 'membership_user_id'
    select "Owner", from: 'membership_role'
    click_on "Add New Member"
    expect(page).to have_content "Goosey Loosey was successfully added"

    select user.full_name, from: 'membership_user_id'
    click_on "Add New Member"
    expect(page).to have_content "User has already been added to this project"
  end

  scenario 'user can update member from index page' do
    project = create_project
    create_membership
    visit project_memberships_path(project)
    expect(page).to have_content "Goosey Loosey"

  end



end
