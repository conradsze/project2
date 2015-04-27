class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create]
  before_action :authorized?, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id.to_s
      flash[:welcome] = "thanks for signing up, #{@user.name}!"
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id]) 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :login_id, :email, :bio, :interest))
      redirect_to @user     
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
     redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :login_id, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
       flash[:error] = "You must be logged in to access thar page!"
       redirect_to login_path
     end
  end

  def authorized?
    unless User.find(params[:id]) == current_user
      flash[:error] = "You must be logged as #{User.find(params[:id]).name} to access thar page!"
      redirect_to users_path
    end
  end
end