class Cheatsheet < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates_length_of :name, minimum: 1, maximum: 254, allow_blank: false

  accepts_nested_attributes_for :scenarios, allow_destroy: true

  def sorted_scenarios
    order_scenarios ||= ""
    order = order_scenarios.split(",")
    scenarios.sort do |a, b|
      order.find_index(a.id.to_s) <=> order.find_index(b.id.to_s)
    end
  end

  def updated_sorted_scenarios
    order_scenarios ||= ""
    order = order_scenarios.split(",").map { |string_id| string_id.to_i }
    scenario_ids_not_sorted = scenarios.select do |scenario|
      order.find_index(scenario.id).nil?
    end.map { |scenario| scenario.id }
    order.push(*scenario_ids_not_sorted)
    order.delete_if do |scenario_id|
      scenarios.map(&:id).find_index(scenario_id).nil?
    end
  end
end
