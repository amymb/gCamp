class ApplicationController < ActionController::Base
  class AccessDenied < StandardError; end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  rescue_from AccessDenied, with: :record_not_found

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end


  def record_not_found
    render file: "public/404.html", status: 404
  end

  def store_location
    session[:return_to] = request.request_uri
  end

end
