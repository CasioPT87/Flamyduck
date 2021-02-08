class ScenariosController < ApplicationController

  before_action :set_cheatsheet

  def new
    @scenario = @cheatsheet.scenarios.build
  end

  def create
    @scenario = @cheatsheet.scenarios.build(scenario_params)
    if @scenario.save
      redirect_to cheatsheet_path(@cheatsheet), notice: "Scenario created"
    else
      redirect_to cheatsheet_path(@cheatsheet), notice: "Scenario failed to created"
    end
  end

  private

  def scenario_params
    params.require(:scenario).permit(:content, :example, :cheatsheet_id)
  end 

  def set_cheatsheet
    @cheatsheet = Cheatsheet.find(params[:cheatsheet_id])
  end

end
