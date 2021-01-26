class Group < ApplicationRecord
  has_many :cheatsheets

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 20, allow_blank: false
  
end
