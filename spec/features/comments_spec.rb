require 'rails_helper'

feature 'user can comment on tasks' do
  scenario 'comment can be created and shown' do
    task = create_task
    user_2 = create_user_2
    Membership.create!(project_id: task.project.id, user_id: user_2.id, role: 'Member')
    sign_in_user_2
    visit project_task_path(task.project, task)

    fill_in "comment_body", with: "blah blah blah"

    click_on "Add Comment"

    expect(page).to have_content "blah blah blah"
    expect(page).to have_content "less than a minute ago"
    expect(page).to have_content "Piglet Smith"
  end

  scenario 'if user is deleted, comment author changes to deleted user' do
      task = create_task
      user = create_user
      comment = Comment.create!(user_id: user.id, task_id: task.id, body: "Swedish fish, peach rings, gummi bears")

      user_2 = create_user_2
      Membership.create!(user_id: user2.id, project_id: task.project.id)
      sign_in_user_2

      visit project_task_path(task.project, task)

      expect(page).to have_content "Goosey Loosey"
      expect(page).to have_content "Swedish fish, peach rings, gummi bears"

      visit users_path

      click_on user.first_name

      click_on "Edit"

      click_on "Delete"

      visit project_task_path(task.project, task)

      expect(page).to have_content "Swedish fish, peach rings, gummi bears"
      expect(page).to_not have_content "Goosey Loosey"
      expect(page).to have_content "(deleted user)"
    end

end
