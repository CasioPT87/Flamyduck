class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
   @user = User.new(params.require(:user).permit(:name, :password))
   if @user.save
    debugger
    session[:user_id] = @user.id
    flash[:notice] = 'User created successfuly'
    redirect_to '/'
   else
    debugger
    flash[:alert] = @user.errors.full_messages.join(', ')
    redirect_to new_user_path
   end
  end
end
