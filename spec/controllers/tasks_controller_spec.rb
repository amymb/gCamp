require 'rails_helper'
describe TasksController do
  before(:each) do
    @user_2 = create_user_2
    session[:user_id] = @user_2.id
  end


  describe 'GET #index' do
    it "assigns @project.tasks" do
      task = create_task
      get :index, project_id: @project
      expect(assigns(:tasks)).to eq [task]
    end

    it "will not allow unauthenticated users to view tasks" do
      session[:user_id] = nil
      task = create_task
      get :index, project_id: @project
      expect(response).to_not render_template(:index)
      expect(response).to redirect_to sign_in_path
    end

    it "will not allow non-members to view tasks" do
      task = create_task
      user = create_user({admin: false})
      session[:user_id] = user.id

      get :index, project_id: @project
      expect(response).to_not render_template(:index)
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq 'You do not have access to that project'
    end

    it "will allow members to view tasks" do
      user = create_user({email: "johnny@email.com", admin: false})
      session[:user_id] = user.id
      membership = create_membership({user_id: user.id, role: "Member"})

      get :index, project_id: @project
      expect(response).to render_template(:index)
    end

    it 'will allow admin to view tasks' do
      project = create_project
      user = create_user
      session[:user_id] = user.id
      get :index, project_id: project.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it "will not allow non admin, non members to view new task template" do
      project = create_project
      user = create_user({admin: false})
      session[:user_id] = user.id

      get :new, project_id: project.id
      expect(response).to_not render_template :new
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it "will allow admins to view new task template" do
      project = create_project
      user = create_user
      session[:user_id] = user.id
      get :new, project_id: project.id
      expect(response).to render_template :new
    end

    it "will allow members to view new task template" do
      membership = create_membership ({role: "Member"})
      session[:user_id] = @user.id
      get :new, project_id: @project.id
      expect(response).to render_template :new
    end

    it "assigns @project.tasks.new to new task" do
      project = create_project
      get :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    it "asssigns @project.tasks to updated task" do
      project = create_project
      post :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "creates a new task when valid params are passed" do
      project = create_project
      expect{post :create, project_id: project.id, task:{description: "pointer"}}.to change{project.tasks.all.count}.from(0).to(1)
    end

    it "does not allow non-member non-admins to create a task" do
      project = create_project
      user = create_user({admin: false})
      user.memberships.delete_all
      session[:user_id] = user.id
      expect{post :create, project_id: project.id, task:{description: "pointer"}}.to_not change{project.tasks.all.count}
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it "allows members to create a new task" do
      project = create_project
      user = create_user({admin: false})
      membership = Membership.create!(project_id: project.id, user_id: user.id, role: "Member")
      session[:user_id] = user.id
      expect{post :create, project_id: project.id, task:{description: "pointer"}}.to change{project.tasks.all.count}.from(0).to(1)
      expect(response).to redirect_to project_task_path(project, Task.last)
      expect(flash[:notice]).to eq "Task was successfully created"
    end

    it "allows admins to create a new task" do
      project = create_project
      user = create_user
      session[:user_id] = user.id
      expect{post :create, project_id: project.id, task:{description: "pointer"}}.to change{project.tasks.all.count}.from(0).to(1)
      expect(response).to redirect_to project_task_path(project, Task.last)
      expect(flash[:notice]).to eq "Task was successfully created"
    end
  end

  describe "GET #show" do
    it "assigns tasks" do
      task = create_task
      get :show, project_id: @project.id, id: task.id
      expect(assigns(:task)).to eq task
    end

    it "does not allow non members non admins to see task" do
      task = create_task
      user = create_user({admin: false})
      session[:user_id] = user.id
      get :show, project_id: @project.id, id: task.id
      expect(response).to_not render_template(:show)
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it "allows members to see task" do
      project = Project.create!(name: "Boom")
      task = create_task({project_id: project.id})
      membership = create_membership({project_id: project.id})
      session[:user_id] = @user.id
      get :show, project_id: project.id, id: task.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "assigns tasks" do
      task = create_task
      get :edit, project_id: @project.id, id: task.id
      expect(assigns(:task)).to eq task
    end

    it "does not allow non members or non admins to see task" do
      task = create_task
      user = create_user({admin: false})
      session[:user_id] = user.id
      get :edit, project_id: @project.id, id: task.id
      expect(response).to_not render_template(:edit)
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end
  end

  describe "PATCH #update" do
    it "does not allow non members or non admins to update task" do
      task = create_task
      user = create_user({admin: false})
      session[:user_id] = user.id
      expect{patch :update, project_id: @project.id, id: task.id, task:{description: "pointer"}}.to_not change{@project.tasks}
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it "allows admins to update task" do
      task = create_task
      user = create_user
      session[:user_id] = user.id
      expect{patch :update, project_id: @project.id, id: task.id, task:{description: "pointer"}}.to change{@project.tasks.last.description}.from("baaaa").to("pointer")
      expect(response).to redirect_to project_task_path(@project.id, task.id)
      expect(flash[:notice]).to eq "Task was successfully updated"
    end
  end

  describe "DELETE #destroy" do
    it "does not allow non members or non admins to delete task" do
      task = create_task
      user = create_user({admin: false})
      session[:user_id] = user.id
      expect{delete :destroy, project_id: @project.id, id: task.id}.to_not change{@project.tasks.all.count}
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

    it "allows members to delete task" do
      project = Project.create!(name: "Boom")
      task = create_task({project_id: project.id})
      membership = create_membership({project_id: project.id})
      session[:user_id] = @user.id
      expect{delete :destroy, project_id: project.id, id: task.id}.to change{project.tasks.all.count}.by(-1)
      expect(response).to redirect_to project_tasks_path(project.id)
    end
  end


end
