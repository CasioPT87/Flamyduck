class User < ApplicationRecord

  has_secure_password

  has_many :groups, as: :creator
  has_and_belongs_to_many :groups

  has_many :cheatsheets

  validates :name, presence: true, format: { with: /\A[\w-]+\z/, message: "User name can only contain letters, digits, dashes and underscores" }
  validates_length_of :name, :maximum => 15, :minimum => 3, allow_blank: false, allow_nil: false,
    message: "User name must be within 3 and 15 characters"

  validates :password, presence: true, allow_blank: false
  validate :password_requirements_are_met

  def password_requirements_are_met
    rules = {
      " must contain at least one lowercase letter"  => /[a-z]+/,
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " must contain at least one digit"             => /\d+/
    }
  
    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex )
    end
  end
  
end
