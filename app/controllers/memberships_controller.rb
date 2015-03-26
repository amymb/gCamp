class MembershipsController < PrivateController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :ensure_member
  before_action :ensure_owner, only: [:update, :destroy]

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

  def update
    @membership =Membership.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    flash[:notice] = "#{membership.user.full_name} was successfully removed"
    redirect_to project_memberships_path
  end


  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end
end
