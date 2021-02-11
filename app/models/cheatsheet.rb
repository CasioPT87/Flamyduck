class Cheatsheet < ApplicationRecord
  has_rich_text :description
  has_many :scenarios, inverse_of: 'cheatsheet'
  belongs_to :user
  has_and_belongs_to_many :cheatsheets

  validates :name, presence: true
  validates_length_of :name, minimum: 3, maximum: 30, allow_blank: false

  accepts_nested_attributes_for :scenarios, allow_destroy: true

  def self.available_collection
    Cheatsheet.find_by(user: current_user)
  end
end
