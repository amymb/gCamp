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
      expect(assigns(:project)).to eq [project]
    end

    it "allows members to view @projct" do
      project = create_project
      user = create_user({admin: false})
      session

    it "renders the show template" do
      get :show
      expect(subject).to render_template(:show)
    end
  end


  # describe "GET #edit" do
  #   it "assigns a project object" do
  #     project = create_project
  #
  #     get :edit, id: project.id
  #     expect(assigns(:project)).to eq project
  #   end
  # end
end
