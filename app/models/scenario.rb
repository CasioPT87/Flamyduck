class Scenario < ApplicationRecord
  belongs_to :cheatsheet

  validates :name, presence: true
end
