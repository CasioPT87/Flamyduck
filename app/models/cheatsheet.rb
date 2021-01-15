class Cheatsheet < ApplicationRecord
  belongs_to :group
  has_many :cases
end
