class Logged::CheatsheetsController < ApplicationController
  before_action :authorized
  before_action :set_cheatsheet, only: [:update, :destroy, :edit, :show]

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
    @group = get_group
    if @cheatsheet.update(cheatsheet_params)
      if @group
        redirect_to group_cheatsheet(@group, @cheatsheet)
      else
        redirect_to cheatsheet_path(@group, @cheatsheet)
      end
    else
      redirect_to cheatsheet_path(@cheatsheet)
    end
  end

  def show
    @scenarios = Scenario.find_by(cheatsheet: @cheatsheet)
    @group = get_group
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

  def get_group
    if params[:group_id]
      Group.find(params[:group_id])
    end
  end
end
