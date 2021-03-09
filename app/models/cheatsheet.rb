class Cheatsheet < ApplicationRecord
  has_many :scenarios
  belongs_to :user
  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 30, allow_blank: false

  accepts_nested_attributes_for :scenarios, allow_destroy: true

  def sorted_scenarios
    return scenarios if scenarios.size < 2
    order = order_scenarios.split(",")
    scenarios.sort do |a, b|
      order.find_index(a.id.to_s) <=> order.find_index(b.id.to_s)
    end
  end

  def update_sorted_scenarios
    return scenarios if scenarios.size < 2
    add_created_scenario_to_sorted
    remove_delted_scenario_from_sorted
  end

  private

  def add_created_scenario_to_sorted
    order = order_scenarios.split(",").map { |string_id| string_id.to_i }
    scenario_ids_not_sorted = scenarios.select do |scenario|
      order.find_index(scenario.id).nil?
    end.map { |scenario| scenario.id }
    order.push(*scenario_ids_not_sorted)
    self.update(order_scenarios: order.join(','))
  end

  def remove_delted_scenario_from_sorted
    order = order_scenarios.split(",").map { |string_id| string_id.to_i }
    order.delete_if do |scenario_id|
      scenarios.map(&:id).find_index(scenario_id).nil?
    end
    self.update(order_scenarios: order.join(','))
  end
end
