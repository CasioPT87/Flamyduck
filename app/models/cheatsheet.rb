class Cheatsheet < ApplicationRecord
  has_rich_text :description

  has_many :cases
  belongs_to :user

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 30, allow_blank: false
end
