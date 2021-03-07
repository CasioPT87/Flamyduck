class Logged::SortsController < ApplicationController
  before_action :authorized

  def update
    scenario = Scenario.find_by(sort_allowed_params[:id])
    cheatsheet = scenario.cheatsheet
    if cheatsheet.update(order_scenarios: sort_allowed_params[:order])
    else
      flash[:alert] = 'Sort action failed'
    end
  end

  private

  def sort_allowed_params
    params.permit(:id, :order, :authenticity_token)
  end
end
