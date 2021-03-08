class SessionsController < ApplicationController
  def new
    render 'login'
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Logged successfuly'
      redirect_to '/'
    else
      flash[:alert] = 'Name or password not correct'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
