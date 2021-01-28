class Logged::CheatsheetsController < ApplicationController
  before_action :authorized
  def index
    @cheatsheets = Cheatsheet.where(user: current_user)
  end

  def new
    @cheatsheet = Cheatsheet.new
  end

  def create
    @cheatsheet = Cheatsheet.new(cheatsheet_params)
    @cheatsheet.user = current_user
    if @cheatsheet.save
      redirect_to @cheatsheet
    else
      render 'new'
    end
  end

  def show
    @cheatsheet = Cheatsheet.find(params[:id])
  end

  private

  def cheatsheet_params
    params.require(:cheatsheet).permit(:name, :description)
  end
end
