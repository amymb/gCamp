namespace :cleanup do
  desc 'Removes all memberships where their users have already been deleted'
    task bye: :environment do
      memberships_without_users = Membership.where.not(user_id: User.pluck(:id)).delete_all
      puts "#{memberships_without_users} memberships without users were removed"
    end


  desc 'Removes all memberships where their projects have already been deleted'
    task bye: :environment do
      memberships_without_projects = Membership.where.not(project_id: Project.pluck(:id)).delete_all
      puts "#{memberships_without_projects} memberships without projects were removed"
    end


  desc 'Removes all tasks where their projects have been deleted'
    task bye: :environment do
      tasks_without_projects = Task.where.not(project_id: Project.pluck(:id)).delete_all
      puts "#{tasks_without_projects} tasks without projects were removed"
    end


  desc 'Removes all comments where their tasks have been deleted'
    task bye: :environment do
      comments_without_tasks = Comment.where.not(task_id: Task.pluck(:id)).delete_all
      puts "#{comments_without_tasks} comments without tasks were removed"
    end


  desc 'Sets the user_id of comments to nil if their users have been deleted'
    task bye: :environment do
      comments_without_users = Comment.where.not(user_id: User.pluck(:id)).update_all(user_id: nil)
        puts "#{comments_without_users} comments without users had user_id replaced with nil"
      end

    desc 'Removes any tasks with null project_id'
      task bye: :environment do
        tasks_with_null_projects = Task.where(project_id: nil).delete_all
        puts "#{tasks_with_null_projects} tasks with project id of null have been deleted"
      end


    desc 'Removes any comments with a null task_id'
      task bye: :environment do
        comments_with_null_task_id = Comment.where(task_id: nil).delete_all
        puts "#{comments_with_null_task_id} comments with null task id have been deleted"
      end


    desc 'Removes any memberships with a null project_id'
      task bye: :environment do
        memberships_with_null_project_id = Membership.where(project_id: nil).delete_all
        puts "#{memberships_with_null_project_id} memberships with null project id have been deleted"
      end

    desc 'Removes any memberships with a null user_id'
      task bye: :environment do
        memberships_with_null_user_id = Membership.where(user_id: nil).delete_all
        puts "#{memberships_with_null_user_id} memberships with null user id have been deleted"
      end


    end
