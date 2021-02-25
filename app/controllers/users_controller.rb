class UsersController < ApplicationController
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
    flash[:alert] = 'User could not be created'
    redirect_to new_user_path
   end
   
  end
end
