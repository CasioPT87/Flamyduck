class ScenariosController < ApplicationController
  before_action :authorized
  before_action :set_scenario, only: [:update]

  def update
    cheatsheet = @scenario.cheatsheet
    if @scenario.update(scenario_params)
      flash[:notice] = 'Edited successfully'
      redirect_to cheatsheet_path(cheatsheet)
    else
      flash[:alert] = @scenario.errors.full_messages.join(', ')
      redirect_to cheatsheet_path(cheatsheet)
    end
  end

  private

  def set_scenario
    @scenario = Scenario.find(params[:id])
  end

  def scenario_params
    params.require(:scenario).permit(:content, :example)
  end
end