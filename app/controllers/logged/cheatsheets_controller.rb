class Logged::CheatsheetsController < ApplicationController
  before_action :authorized
  def index
    @cheatsheets = Cheatsheet.where(user: current_user)
  end

  def new
    @cheatsheet = Cheatsheet.new
  end

  def create
    byebug
    @cheatsheet = Cheatsheet.new(cheatsheet_params)
    if @cheatsheet.save
      render @cheatsheet
    else
      render 'new'
    end
  end

  private

  def cheatsheet_params
    params.require(:cheatsheet).permit(:name)
  end
end
