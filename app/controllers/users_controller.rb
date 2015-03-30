class UsersController < PrivateController
before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :ensure_authenticated
before_action :ensure_current_user, only: [:edit, :update, :destroy]
before_action :ensure_self_or_admin, only: [:edit, :udpate, :destroy]

  def index
      @users=User.all
  end

  def new
    @user=User.new
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
      session[:user_id] = nil
      @user.destroy
      redirect_to root_path
  end


  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
