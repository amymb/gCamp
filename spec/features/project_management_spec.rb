require 'rails_helper'

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

  scenario 'user can create new projects' do
    sign_in_user
    visit projects_path

    click_link "New Project"
    click_button "Create Project"

    expect(page).to have_content "Name can't be blank"

    fill_in "Name", with: "Greatest Project of All Time"
    click_button "Create Project"

    expect(page).to have_content "Project was successfully created"
    expect(page).to have_content "Greatest Project of All Time"

    within(".breadcrumb") do
      click_on "Projects"
    end

    expect(page).to have_content "Greatest Project of All Time"

  end

  scenario "user can visit memberships index from projects page" do
    testproject1 = Project.new(name: "Test Project 1")
    testproject1.save!
    sign_in_user

    visit projects_path
    click_on "Test Project 1"
    click_on "0 Memberships"

    expect(page).to have_content "Test Project 1: Manage Members"
  end

  scenario 'user can edit projects' do
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

    within(".breadcrumb") do
      click_on "Projects"
    end

    expect(page).to have_content "Double Frozen Custard"
  end

  scenario 'user can delete projects' do
    create_membership
    Task.create!(description: "baaaa", project_id: @project.id)
    Task.create!(description: "blah", project_id: @project.id)
    sign_in_user
    visit projects_path
    click_link @project.name

    expect(page).to have_content "Deleting this project will also delete 1 membership, 2 tasks and associated comments"
    click_link "Delete"

    expect(page).to have_content "Project was successfully deleted"
    expect(page).to_not have_content @project.name

    visit about_path
    expect(page).to have_content "0 Projects, 0 Tasks, 0 Project Members"

  end

  scenario 'project has breadcrumbs' do

    hotproject = Project.new(name: "Cross Buns")
    hotproject.save!
    sign_in_user

    visit projects_path

    click_link "New Project"

    expect(page).to have_content "Projects New Project"

    within(".breadcrumb") do
      click_on "Projects"
    end

    click_link "Cross Buns"

    expect(page).to have_content "Projects Cross Buns"

    click_link "Edit"

    expect(page).to have_content "Projects Cross Buns Edit"
  end









end
