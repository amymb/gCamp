require 'rails_helper'


describe ProjectsController do
  before(:each) do
    user_2 = create_user_2
    session[:user_id] = user_2.id
  end

  describe "GET #index" do
    it "assigns @projects" do
      project = create_project
      get :index

      expect(assigns(:projects)).to eq [project]
    end

    it "renders the index template" do
      get :index
      expect(subject).to render_template(:index)
    end

    it "will not allow unathenticated users access" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "GET #new" do
    it "assigns a new project object" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the new template" do
      get :new
      expect(subject).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates a new project when valid params are passed" do
      expect{ post :create, project: {name:"Boom"}}.to change{Project.all.count}.from(0).to(1)
      expect(response).to redirect_to project_tasks_path(Project.last)
      expect(flash[:notice]).to eq "Project was successfully created"
    end
  end

  describe "GET #show" do
    it "will not allow non-members to view @project" do
      project = create_project
      user = create_user({admin: false})
      session[:user_id] = user.id
      get :show, id: project
      expect(response).to_not render_template(:show)
    end

    it "assigns a project object" do
      project = create_project
      get :show, id: project
      expect(assigns(:project)).to eq project
    end

    it "allows members to view @project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      get :show, id: project

      expect(response).to render_template(:show)
    end
  end


  describe "GET #edit" do
    it "will not allow non-owners to edit project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      session[:user_id] = @user.id
      get :show, id: project
      expect(response).to_not render_template(:edit)
    end


    it "assigns a project object" do
      project = create_project

      get :edit, id: project.id
      expect(assigns(:project)).to eq project
    end

    it "will allow owners to view edit_project_path" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Owner"})
      session[:user_id] = @user.id
      get :edit, id: project
      expect(response).to render_template(:edit)

    end

    it "will allow non-member admins to view edit_project_path" do
      project = create_project
      user_3 = User.create!(
        first_name: "larry",
        last_name: "s",
        email: "larry@email.com",
        password: "password",
        password_confirmation: "password",
        admin: true)
      session[:user_id] = user_3.id
      get :edit, id: project
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #update" do
    it "will not members to update" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      session[:user_id] = @user.id
      expect {
        patch :update, id: project,
        project: {name: "edited test project"}
      }.to_not change{Project.last}
      expect(flash[:warning]).to eq "You do not have access"
      expect(response).to redirect_to project_path(project)
    end

    it "will allow an owner to update project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Owner"})
      session[:user_id] = @user.id
      expect {
        patch :update, id: project.id, project: {name: "edited test project"}
      }.to change{project.reload.name}.from('Test Project').to('edited test project')

      expect(response).to redirect_to project_path(project)
      expect(flash[:notice]).to eq "Project was successfully updated"
    end

    it "will allow an admin to update" do
      project = create_project
      user_3 = User.create!(
        first_name: "larry",
        last_name: "s",
        email: "larry@email.com",
        password: "password",
        password_confirmation: "password",
        admin: true)
      session[:user_id] = user_3.id
      expect {
        patch :update, id: project.id, project: {name: "edited test project"}
      }.to change{project.reload.name}.from('Test Project').to('edited test project')

      expect(response).to redirect_to project_path(project)
      expect(flash[:notice]).to eq "Project was successfully updated"
    end
  end

  describe "DELETE #destroy" do
    it "will not allow non-owner, non-admin to delete a project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      session[:user_id] = @user.id
      expect {
        delete :destroy, id: project
      }.to_not change{Project.all.count}
      expect(flash[:warning]).to eq "You do not have access"
    end

    it "will allow non-owner, admin to delete a project" do
      project = create_project
      user_3 = User.create!(
        first_name: "larry",
        last_name: "s",
        email: "larry@email.com",
        password: "password",
        password_confirmation: "password",
        admin: true)
      session[:user_id] = user_3.id
      expect {
        delete :destroy, id: project
      }.to change{Project.all.count}.by(-1)
      expect(flash[:notice]).to eq "Project was successfully deleted"
    end

    it "will allow an owner to delete a project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Owner"})
      session[:user_id] = @user.id
      expect {
        delete :destroy, id: project
      }.to change{Project.all.count}.by(-1)
      expect(flash[:notice]).to eq "Project was successfully deleted"
    end
  end

end
