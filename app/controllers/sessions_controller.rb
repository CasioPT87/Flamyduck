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

  def edit
  end

  def recover_email
    allowed_params = params.permit(:email)
    @user = User.find_by(email: allowed_params[:email])
    if @user
      UserMailer.with(user: @user).recover_email.deliver_later
      flash[:notice] = 'Your recovery mail will be sent in a moment'
      redirect_to '/reset-password'
    else
      flash[:alert] = 'We couldn not find an user with that email'
      redirect_to '/reset-password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
