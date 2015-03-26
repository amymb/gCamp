class PrivateController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_authenticated

  def ensure_authenticated
    unless current_user
    flash[:blah] ='You must sign in'
    redirect_to sign_in_path
    end
  end

  def ensure_member
    if !current_user.projects.include?(@project)
      flash[:warning] ="You do not have access to that project"
      redirect_to projects_path
    end
  end

  def ensure_owner
    if current_user.memberships.find_by(project_id: @project).role != "Owner"
      flash[:warning] ="You do not have access"
      redirect_to projects_path
    end
  end

end
