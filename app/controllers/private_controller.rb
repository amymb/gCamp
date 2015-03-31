class PrivateController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_authenticated

  def ensure_authenticated
    unless current_user
    session[:return_to] = request.path
    flash[:blah] ='You must sign in'
    redirect_to sign_in_path
    end
  end

  def ensure_member
    if current_user.admin == false && !current_user.projects.include?(@project)
      flash[:warning] ="You do not have access to that project"
      redirect_to projects_path
    end
  end

  def ensure_owner_or_admin
    if current_user.admin == false && (current_user.memberships.find_by(project_id: @project).role != "Owner")
      flash[:warning] ="You do not have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_owner_or_self
    if current_user.admin == false && (!(current_user.memberships.find_by(project_id: @project).role == "Owner" || current_user.id == @membership.user_id))
      flash[:warning] ="You do not have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_owner_is_present
    if (@project.memberships.where(role: "Owner").count <= 1 && @membership.role == "Owner")
      flash[:warning] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project)
    end
  end

  def ensure_self_or_admin
    if !current_user_or_admin(@user)
      raise AccessDenied
    end
  end

  def current_user_or_admin(user)
    (user.id == current_user.id) || (current_user.admin)
  end



end
