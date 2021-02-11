class Logged::GroupsController < ApplicationController

  before_action :set_group, only: [:index, :update]

  def index
    @groups = Group.where(creator: current_user)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def update
    if group_params[:cheatsheet_ids]
      if @group.cheatsheet_ids = group_params[:cheatsheet_ids]
        debugger
        redirect_to groups_path(@group) and return
      else
        redirect_to groups_path(@group) and return
      end
    else
      if @group.update(group_params)
        redirect_to groups_path(@group) and return
      else
        redirect_to groups_path(@group) and return
      end
    end
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:id, :name, :cheatsheet_ids => [])
  end

  def set_group
    if id_param
      @group = Group.find(id_param)
      set_available_cheatsheets
    end
  end

  def id_param
    if params[:group] && group_params[:id]
      return group_params[:id]
    else
      if params[:id]
        return params[:id] 
      else
        return nil
      end
    end
  end

  def set_available_cheatsheets
    @cheatsheets = Cheatsheet.where(user: current_user)
  end
end
