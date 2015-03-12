require 'rails_helper'

feature 'user can comment on tasks' do
  scenario 'comment can be created and shown' do
    task = create_task
    sign_in_user
    visit project_task_path(task.project, task)

    fill_in "comment_body", with: "blah blah blah"

    click_on "Add Comment"

    expect(page).to have_content "blah blah blah"
    expect(page).to have_content "less than a minute ago"
    expect(page).to have_content "Piglet Smith"

  end
end
