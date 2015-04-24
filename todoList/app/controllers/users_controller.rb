class UsersController < ApplicationController
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

  private
  def user_params
    params.require(:user).permit(:name, :login_id, :email, :password, :password_confirmation)
  end
end