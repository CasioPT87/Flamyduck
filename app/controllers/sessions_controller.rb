class SessionsController < ApplicationController
  def new
    render 'login'
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to '/'
    else
       redirect_to '/login'
    end
  end

  def login
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
