class Logged::CheatsheetsController < ApplicationController
  before_action :authorized
  before_action :set_cheatsheet, only: [:update, :destroy, :edit]

  def index
    @cheatsheets = Cheatsheet.where(user: current_user)
  end

  def new
    @cheatsheet = Cheatsheet.new
  end

  def edit
  end

  def create
    @cheatsheet = Cheatsheet.new(cheatsheet_params)
    @cheatsheet.user = current_user
    if @cheatsheet.save
      redirect_to cheatsheets_path
    else
      render 'new'
    end
  end

  def update
    if @cheatsheet.update(cheatsheet_params)
      redirect_to cheatsheet_path(@cheatsheet)
    else
      redirect_to cheatsheet_path(@cheatsheet)
    end
  end

  def show
    @cheatsheet = Cheatsheet.find(params[:id])
    @scenarios = Scenario.find_by(cheatsheet: @cheatsheet)
  end

  def destroy
    if @cheatsheet.destroy
      redirect_to cheatsheets_path
    else
      redirect_to cheatsheets_path
    end
  end

  private

  def cheatsheet_params
    params.require(:cheatsheet).permit(:name, scenarios_attributes: [:id, :content, :example, :_destroy])
  end

  def set_cheatsheet
    @cheatsheet = Cheatsheet.find(params[:id])
  end
end
