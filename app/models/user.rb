class User < ApplicationRecord

  has_secure_password

  has_many :groups, as: :creator
  has_and_belongs_to_many :groups

  has_many :cheatsheets

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 20, allow_blank: false
  
end
