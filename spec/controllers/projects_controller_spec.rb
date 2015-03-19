require 'rails_helper'


describe ProjectsController do
  before(:each) do
    user = create_user
    session[:user_id] = user.id
  end

  describe "GET #index" do
    it "assigns @projects" do
      project = create_project
      get :index

      expect(assigns(:projects)).to eq [project]
    end
  end

  describe "GET #new" do
    it "assigns a new project object" do

      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "POST #create" do
    it "creates a new project when valid params are passed" do
      expect{ post :create, project: {name:"Boom"}}.to change{Project.all.count}.from(0).to(1)
      #expect(response).to redirect_to project_path(Project.find[where(Project.name == "Boom")])
      expect(flash[:notice]).to eq "Project was successfully created"
    end
  end

  describe "GET #edit" do
    it "assigns a project object" do
      project = create_project

      get :edit, id: project.id
      expect(assigns(:project)).to eq project
    end
  end
end
