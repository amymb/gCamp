require 'rails_helper'

feature 'Can CRUD tasks' do
  scenario 'User can create and see tasks in show and index pages' do
    visit root_path
    sign_in_user
    click_link 'Tasks'
    click_link 'New Task'

    click_button 'Create Task'
    expect(page).to have_content 'Description can\'t be blank'

    fill_in "Description", with: 'Exciting Task'
    click_button 'Create Task'

    expect(page).to have_content 'Exciting Task'
    expect(page).to have_content "Task was successfully created"
    click_link('Tasks', match: :first)

    expect(current_path).to eq "/tasks"
    expect(page).to have_content 'Exciting Task'
  end

  scenario 'User can update tasks and destroy tasks' do
    fun_task = Task.new(description: 'Fun Task', due_date: "12-12-18")
    fun_task.save!
    sign_in_user
    visit tasks_path
    click_link 'Fun Task'
    click_link 'Edit'
    fill_in 'Description', with: ""
    click_button 'Update Task'

    expect(page).to have_content 'Description can\'t be blank'

    fill_in "Description", with: "Really Fun Task"
    click_button 'Update Task'

    expect(page).to have_content 'Task was successfully updated'

    click_link('Tasks', match: :first)
    click_link 'Destroy'

    expect(page).to_not have_content 'Really Fun Task'
    expect(page).to_not have_content '12/12/18'
  end
end
