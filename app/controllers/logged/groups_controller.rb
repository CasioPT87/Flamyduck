class Logged::GroupsController < ApplicationController

  before_action :set_group, only: [:show, :update, :edit, :destroy]

  def index
    @groups = Group.where(creator: current_user)
  end

  def new
    @group = Group.new
  end

  def edit
    @cheatsheets = available_cheatsheets
  end

  def create
    group = Group.new(group_params)
    group.creator = current_user
    if group.save
      flash[:notice] = 'Created successfully'
      redirect_to groups_path
    else
      flash[:alert] = 'Could not create'
      redirect_to new_group_path
    end
  end

  def update 
    @group.cheatsheet_ids = group_params[:cheatsheet_ids]
    if @group.update(group_params)
      flash[:notice] = 'Edited successfully'
      redirect_to edit_group_path(@group)
    else
      flash[:alert] = 'Could not edit'
      redirect_to edit_group_path(@group)
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = 'Deleted successfully'
      redirect_to groups_path
    else
      flash[:alert] = 'Could not delete'
      redirect_to groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:id, :name, :cheatsheet_ids => [])
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def available_cheatsheets
    Cheatsheet.where(user: current_user)
  end
end
