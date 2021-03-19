class SessionsController < ApplicationController
  def new
    render 'login'
  end

  def create
    users = User.where(name: params[:name])
    @user = users.find { |user| user.authenticate(params[:password]) }
    if @user
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
