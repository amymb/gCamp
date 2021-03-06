class UsersController < PrivateController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_authenticated
  before_action :ensure_self_or_admin, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      redirect_to users_path
      flash[:notice] = "User was successfully created"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "User was successfully deleted"
    if current_user == @user
      @user.destroy
      session[:user_id] = nil
      redirect_to root_path
    else
      @user.destroy
      redirect_to users_path
    end
  end


  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :tracker_token, :admin )
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :tracker_token)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
