class User < ApplicationRecord

  has_secure_password

  has_many :groups, as: :creator
  has_and_belongs_to_many :groups

  has_many :cheatsheets

  validates :name, presence: true, format: { with: /\A[\w-]+\z/, message: "User name can only contain letters, digits, dashes and underscores" }
  validates_length_of :name, :maximum => 15, :minimum => 3, allow_blank: false, allow_nil: false,
    message: "User name must be within 3 and 15 characters"

  validates :password, presence: true, allow_blank: false, unless: :skip_password_validation
  validates_length_of :password, :maximum => 15, :minimum => 6, allow_blank: false, allow_nil: false,
    message: "Password must be within 6 and 15 characters", unless: :skip_password_validation
  validate :password_requirements_are_met, unless: :skip_password_validation

  validates :email, presence: true, allow_blank: false, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 

  attr_accessor :skip_password_validation

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

  def send_password_reset
    self.skip_password_validation = true 
    if self.update(password_reset_token: SecureRandom.urlsafe_base64, password_reset_sent_at: Time.zone.now)
      UserMailer.with(user: self).forgot_password.deliver_later
    end 
  end
  # This generates a random password reset token for the user
  def generate_token(column)
    
  end
  
end
