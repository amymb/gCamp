require 'rails_helper'

#Tasks index should say 'Tasks for (project name)'
#Tasks index breadcrumbs should be "Projects / (name of project) / Tasks
#Tasks show breadcrumbs should be "Projects / (name of project) / Tasks / <name of task>
#Tasks edit and show should be prefaced the same way




feature 'Can CRUD tasks' do

  scenario 'project tasks page linked to from project' do
    project = Project.new(name: "TestProject")
    project.save!

    task = Task.new(description: "TestTask", project_id: project.id)
    task.save!

    sign_in_user
    visit projects_path

    expect(".footer").to_not have_content "Tasks"

    click_on "TestProject"

    click_on "1 Task"

    click_on "TestTask"

    expect(page).to have_content "Due On:"
  end

  scenario 'User can create and see tasks in project task show and project task index pages' do
    project = Project.new(name: "TestProject")
    project.save!

    sign_in_user
    visit projects_path

    click_on "TestProject"
    click_link '0 Tasks'

    click_link 'New Task'

    expect(page).to have_content 'Projects TestProject Tasks New'

    click_button 'Create Task'
    expect(page).to have_content 'Description can\'t be blank'

    fill_in "Description", with: 'Exciting Task'
    click_button 'Create Task'

    expect(page).to have_content 'Exciting Task'
    expect(page).to have_content "Projects TestProject"
    expect(page).to have_content "Task was successfully created"

    click_link('Tasks', match: :first)

    expect(page).to have_content 'Tasks for TestProject'
    expect(page).to have_content "Projects TestProject"

    expect(page).to have_content 'Exciting Task'
  end

  scenario 'User can update tasks and destroy tasks' do
    project = Project.new(name: "TestProject")
    project.save!
    fun_task = Task.new(description: 'Fun Task', due_date: "12-12-18", project_id: project.id)
    fun_task.save!

    sign_in_user
    visit projects_path

    click_on "TestProject"
    click_link '1 Task'


    click_link 'Fun Task'
    click_link 'Edit'

    expect(page).to have_content "Projects TestProject Tasks Fun Task Edit"
    fill_in 'Description', with: ""
    click_button 'Update Task'

    expect(page).to have_content 'Description can\'t be blank'

    fill_in "Description", with: "Really Fun Task"
    click_button 'Update Task'

    expect(page).to have_content 'Task was successfully updated'

    click_link('Tasks', match: :first)
    find(".glyphicon-remove").click

    expect(page).to_not have_content 'Really Fun Task'
    expect(page).to_not have_content '12/12/18'
  end


  scenario 'user can see number of tasks from project index page' do
    project = Project.new(name: "TestProject")
    project.save!
    fun_task = Task.new(description: 'Fun Task', due_date: "12-12-18", project_id: project.id)
    fun_task.save!
    sign_in_user

    visit projects_path

    expect(page).to have_content "TestProject"
    click_on "1"

    expect(page).to have_content "Fun Task"
  end

end
