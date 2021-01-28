class Cheatsheet < ApplicationRecord
  has_rich_text :description

  has_many :cases
  belongs_to :user
end
