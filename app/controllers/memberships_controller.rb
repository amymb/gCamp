class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
  end

  def create
    membership = @project.memberships.new(membership_params)
    if membership.save
      flash[:notice] = "#{membership.user.full_name} was successfully added"
      redirect_to project_memberships_path
    else
      @membership = membership
      render :index
    end
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end
end
