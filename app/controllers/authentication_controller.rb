class AuthenticationController < PublicController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed in"
      redirect_back_or_default
    else
      flash[:fun] = "Email / Password combination is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:return_to] = nil
    flash[:notice] = "You have successfully signed out"
    redirect_to root_path
  end

  def redirect_back_or_default
    if session[:return_to] !=nil
      redirect_to session[:return_to]
    else
      redirect_to projects_path
    end
  end

end
