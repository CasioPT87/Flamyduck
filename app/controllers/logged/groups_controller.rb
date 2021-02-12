class Logged::GroupsController < ApplicationController

  before_action :set_group, only: [:show, :update, :edit]

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
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def update 
    @group.cheatsheet_ids = group_params[:cheatsheet_ids]
    @group.update(group_params)
    redirect_to edit_group_path(@group)
  end

  def destroy
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
