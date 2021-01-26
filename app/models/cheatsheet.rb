class Cheatsheet < ApplicationRecord
  has_many :cases

  
  belongs_to :user
end
