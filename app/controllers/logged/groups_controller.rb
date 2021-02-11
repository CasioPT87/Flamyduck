class Logged::GroupsController < ApplicationController

  before_action :set_group, only: [:index]

  def index
    @groups = Group.where(creator: current_user)
  end

  def new
    @group = Group.new
  end

  def create
    debugger
    @group = Group.new(group_params)
    @group.creator = current_user
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:id, :name)
  end

  def set_group
    if params[:group] && group_params[:id]
      @group = Group.find(group_params[:id])
    end
  end
end
