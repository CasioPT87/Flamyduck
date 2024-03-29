class Cheatsheet < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates_length_of :name, minimum: 1, maximum: 254, allow_blank: false

  accepts_nested_attributes_for :scenarios, allow_destroy: true

  def sorted_scenarios
    order = order_scenarios ? order_scenarios.split(",") : []
    scenarios.sort do |a, b|
      order.find_index(a.id.to_s) <=> order.find_index(b.id.to_s)
    end
  end

  def add_scenario_to_sort_list(scenario_id)
    order = order_scenarios ? order_scenarios.split(",") : []
    order_ids = order.map { |string_id| string_id.to_i }
    order_ids.push(scenario_id)
    self.update(order_scenarios: order_ids.join(","))
  end

  def delete_scenario_from_sort_list(scenario_id)
    order = order_scenarios ? order_scenarios.split(",") : []
    order_ids = order.map { |string_id| string_id.to_i }
    order_ids.delete(scenario_id)
    self.update(order_scenarios: order_ids.join(","))
  end
end
