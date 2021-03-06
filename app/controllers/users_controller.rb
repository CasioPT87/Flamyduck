class UsersController < ApplicationController
  before_action :authorized, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :password))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'User created successfuly'
      redirect_to '/'
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      redirect_to new_user_path
    end
  end

  def edit
    debugger
    @user = current_user
  end

  def update 
  end
end
