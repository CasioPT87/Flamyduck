class Scenario < ApplicationRecord
  has_rich_text :description
  
  belongs_to :cheatsheet

  validates :content, presence: true
  validates_length_of :content, minimum: 1, maximum: 50, allow_blank: false
end
