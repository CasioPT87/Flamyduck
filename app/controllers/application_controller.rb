class ApplicationController < ActionController::Base

  # this is here just as an example 
  # before_action :authorized
  # skip_before_action :authorized, only: [:new, :create]

  # to make this accesible to the views
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to '/login' unless logged_in?
  end
end
