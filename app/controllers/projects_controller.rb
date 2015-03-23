class ProjectsController < ApplicationController
  before_action :ensure_authenticated
  def index
      @projects = Project.all
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
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path
      flash[:notice] = "Project was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path
      flash[:notice] = "Project was successfully deleted"
    else
      render :show
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

end
