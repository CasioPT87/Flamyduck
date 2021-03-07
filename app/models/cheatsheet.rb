class Cheatsheet < ApplicationRecord
  has_many :scenarios
  belongs_to :user
  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 30, allow_blank: false

  accepts_nested_attributes_for :scenarios, allow_destroy: true

  def sorted_scenarios
    return scenarios if order_scenarios.nil?
    return scenarios.sort do |a, b|
      order_scenarios.split(",").find_index(a.id.to_s) <=> order_scenarios.split(",").find_index(b.id.to_s)
    end
  end

end
