class TasksController < ApplicationController
  before_action :require_login,

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id]) 
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
       current_user.tasks<<@task
       @current_user.save
     redirect_to task_path(current_user.tasks.last)
    else
      render :new
    end
  end

  def join
       @task = Task.find(params[:id]) 
       current_user.tasks<<@task
       current_user.save
     redirect_to task_path(@task)
  end

    def unjoin
       @task = Task.find(params[:id]) 
       current_user.tasks.delete(Task.find(@task))
       current_user.save
     redirect_to task_path(@task)
  end


  def edit
    @task = Task.find(params[:id]) 
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
     redirect_to user_path(current_user)
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :event_type, :location , :day, :month, :year)
  end

  def require_login
    unless logged_in?
       flash[:error] = "You must be logged in to access thar page!"
       redirect_to login_path
     end
  end
end