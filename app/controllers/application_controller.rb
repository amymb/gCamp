class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :ensure_authenticated

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end

  def ensure_authenticated
    unless current_user
    flash[:blah] ='You must sign in'
    redirect_to sign_in_path
    end
  end

  def ensure_member
    if !current_user.projects.include?(Project.find(params[:id]))
      flash[:notice] ="You do not have access to that project"
      redirect_to projects_path
    end
  end

end
