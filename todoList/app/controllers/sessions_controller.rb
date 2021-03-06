class SessionsController < ApplicationController

  def new
  end

  def create
    
    user = User.find_by(login_id: params[:login][:login_id])

    if user && user.authenticate(params[:login][:password]) 
      session[:user_id] = user.id.to_s
      redirect_to users_path

    else
    flash.now[:danger] = 'Invalid login ID/password combination'
    render :new

    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
