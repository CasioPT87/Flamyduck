class Scenario < ApplicationRecord
  belongs_to :cheatsheet

  validates :name, presence: true
  validates_length_of :name, minimum: 1, maximum: 50, allow_blank: false
end
