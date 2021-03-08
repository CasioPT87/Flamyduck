class UserMailer < ApplicationMailer
  default from: 'recoveryemail@kiria.com'

  def recover_email
    @user = params[:user]
    @url  = "www.as.com"
    mail(to: @user.email, subject: 'Password recovery for Kiria')
  end
end
