class MembershipsController < PrivateController
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :set_membership, only: [:update, :destroy]

  before_action :ensure_member
  before_action :ensure_owner, only: [:update]
  before_action :ensure_owner_or_self, only: [:destroy]
  before_action :ensure_owner_is_present, only: [:update, :destroy]

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
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    @membership.destroy
    flash[:notice] = "#{@membership.user.full_name} was successfully removed"
    if @membership.user_id == current_user.id
      redirect_to projects_path
    else
      redirect_to project_memberships_path
    end
  end

private
  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end


end
