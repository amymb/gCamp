require 'rails-helper'

feature 'can CRUD projects' do
  scenario 'user can see projects from an index page' do
    testproject1 = Project.new(name: "Test Project 1")
    testproject1.save!
    testproject2 = Project.new(name: "Test Project 2")
    testproject2.save!
    sign_in_user
    visit projects_path

    expect(page).to have_content "Test Project 1"
    expect(page).to have_content "Test Project 2"
  end

  scenario 'user can create new projects'
    sign_in_user
    visit projects_path

    click_link "New Project"
    click_link "Create Project"

    expect(page).to have_content "Name can't be blank"

    fill_in "Name", with: "Greatest Project of All Time"
    click_button "Create Project"

    expect(page).to have_content "Project was successfully created"
    expect(page).to have_content "Greatest Project of All Time"

    click_link "Projects"
    expect(page).to have_content "Greatest Project of All Time"
  end

  scenario 'user can edit projects'
    coolproject = Project.new(name: "Frozen Custard")
    coolproject.save!
    sign_in_user
    visit projects_path

    click_link "Frozen Custard"
    click_link "Edit"
    fill_in "Name", with: ""
    click_button "Update"

    expect(page).to have_content "Name can't be blank"

    fill_in "Name", with: "Double Frozen Custard"
    click_button "Update"

    expect(page).to have_content "Project was successfully updated"

    click_link "Projects"
    expect(page).to have_content "Double Frozen Custard"
  end

  scenario 'user can delete projects'
    hotproject = Project.new(name: "Cross Buns")
    hotproject.save!
    sign_in_user
    visit projects_path
    click_link "Cross Buns"
    click_link "Delete"

    expect(page).to have_content "Project was successfully deleted"
    expect(page).to_not have_content "Cross Buns"
  end
end
