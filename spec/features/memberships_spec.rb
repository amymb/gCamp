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
end
