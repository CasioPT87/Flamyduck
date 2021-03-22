class ScenariosController < ApplicationController
  before_action :authorized
  before_action :set_entities, only: [:update, :destroy]

  def update
    cheatsheet = @scenario.cheatsheet
    if @scenario.update(scenario_params)
      flash[:notice] = 'Edited successfully'
    else
      flash[:alert] = @scenario.errors.full_messages.join(', ')
    end
    if @group.nil?
      redirect_to cheatsheet_path(cheatsheet)
    else
      redirect_to group_cheatsheet_path(@group, cheatsheet)
    end
  end

  def create
    create_scenario_params = params.require(:scenario).permit(:content, :example)
    cheatsheet = Cheatsheet.find(params[:cheatsheet_id])
    scenario = Scenario.new(create_scenario_params)
    scenario.cheatsheet = cheatsheet
    set_group
    if scenario.save
      cheatsheet.add_scenario_to_sort_list(scenario.id)
      flash[:notice] = 'Scenario created'
      if @group.nil?
        redirect_to cheatsheet_path(cheatsheet)
      else
        redirect_to group_cheatsheet_path(@group, cheatsheet)
      end
    else
      flash[:alert] = "Couldn't create scenario"
      if @group.nil?
        redirect_to cheatsheet_path(cheatsheet)
      else
        redirect_to group_cheatsheet_path(@group, cheatsheet)
      end
    end
  end

  def destroy
    if @scenario.destroy
      @cheatsheet.delete_scenario_from_sort_list(@scenario.id)
      flash[:notice] = 'Scenario edited'
      if @group.nil?
        redirect_to cheatsheet_path(@cheatsheet)
      else
        redirect_to group_cheatsheet_path(@group, @cheatsheet)
      end
    else
      flash[:alert] = "Couldn't delete scenario"
      if @group.nil?
        redirect_to cheatsheet_path(@cheatsheet)
      else
        redirect_to group_cheatsheet_path(@group, @cheatsheet)
      end
    end
  end

  private

  def set_entities
    @scenario = Scenario.find(params[:id])
    @cheatsheet = @scenario.cheatsheet
    set_group
  end

  def set_group
    group_id = params[:group_id]
    @group = group_id.blank? ? nil : Group.find(group_id)
  end

  def scenario_params
    params.require(:scenario).permit(:content, :example)
  end
end