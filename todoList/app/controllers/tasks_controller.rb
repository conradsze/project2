class TasksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = current_user
    @task = @user.tasks.new
  end

  def create
    @user = current_user
    @task = @user.tasks.new(task_params)
    if @task.save
     redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :type, :location , :day, :month, :year)
  end
end