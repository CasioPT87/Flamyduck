class PasswordResetsController < ApplicationController
  def new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def create
    allowed_params = params.permit(:email)
    @user = User.find_by(email: allowed_params[:email])
    if @user
      @user.send_password_reset
      flash[:notice] = 'Your recovery mail will be sent in a moment'
      redirect_to root_path
    else
      flash[:alert] = 'We couldn not find an user with that email'
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hour.ago
      flash[:alert] = 'Password reset has expired'
      redirect_to new_password_reset_path
    elsif @user.update(user_params)
      flash[:notice] = 'Password resetted! Please log in'
      redirect_to login_path
    else
      flash[:alert] = 'Password not valid'
      redirect_to edit_password_reset_url(@user.password_reset_token)
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:password)
    end
end
