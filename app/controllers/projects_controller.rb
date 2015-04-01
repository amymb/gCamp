class ProjectsController < PrivateController
  before_action :set_project, except: [:index, :new, :create]
  before_action :ensure_authenticated
  before_action :ensure_member, except: [:index, :new, :create]
  before_action :ensure_owner_or_admin, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
    if current_user.tracker_token?
      pivotal_api = PivotalApi.new
      @pivotal_projects = pivotal_api.projects(current_user.tracker_token)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create!(project_id: @project.id, user_id: current_user.id, role: "Owner")
      redirect_to project_tasks_path(@project)
      flash[:notice] = "Project was successfully created"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path
      flash[:notice] = "Project was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path
      flash[:notice] = "Project was successfully deleted"
    else
      render :show
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end


private

  def project_params
    params.require(:project).permit(:name)
  end

end
