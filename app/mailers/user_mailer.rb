class UserMailer < ApplicationMailer
  default from: 'recoveryemail@kiria.com'

  def forgot_password
    @user = params[:user]
    mail(to: @user.email, subject: 'Password recovery for Kiria')
  end
end
