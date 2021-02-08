class Group < ApplicationRecord
  
  belongs_to :creator, polymorphic: true
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 30, allow_blank: false
  
end
