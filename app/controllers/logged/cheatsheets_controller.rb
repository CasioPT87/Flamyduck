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
      flash[:notice] = 'Created successfully'
      redirect_to cheatsheets_path
    else
      flash[:alert] = 'Could not create'
      redirect_to new_cheatsheet_path
    end
  end

  def update
    @group = get_group
    if @cheatsheet.update(cheatsheet_params)
      # @cheatsheet.update_sorted_scenarios
      if @group
        flash[:notice] = 'Edited successfully'
        redirect_to group_cheatsheet(@group, @cheatsheet)
      else
        flash[:notice] = 'Edited successfully'
        redirect_to cheatsheet_path(@cheatsheet)
      end
    else
      flash[:alert] = 'Could not edit'
      redirect_to edit_cheatsheet_path(@cheatsheet)
    end
  end

  def show
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
