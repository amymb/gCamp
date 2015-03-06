class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @members = @project.users
  end


  def membership_params
    params.require(:membership).permit(:user_id, :project_id)
  end
end
