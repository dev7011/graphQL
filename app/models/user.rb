class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  attr_accessor :username_or_email

  enum :role, { user: 0, custom: 1, admin: 2 }

  validates :role, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  def after_confirmation
    WelcomeMailer.send_greetings_notification(self).deliver_now
  end

  def username_or_email
    @username_or_email || self.username || self.email
  end

  class << self
    def find_for_authentication(warden_conditions)
      conditions = warden_conditions.dup
      username_or_email = conditions.delete(:username_or_email)

      scope = self.all
      scope = scope.where(conditions.to_h)

      if username_or_email
        value = username_or_email.to_s.downcase
        scope = scope.where("LOWER(username) = ? OR LOWER(email) = ?", value, value)
      end

      scope.first
    end
  end
end

