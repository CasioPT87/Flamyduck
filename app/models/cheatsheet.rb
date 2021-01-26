class Cheatsheet < ApplicationRecord
  belongs_to :group, required: false
  has_many :cases
end
