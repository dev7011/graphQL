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

  enum :role, { user: 0, custom: 1, admin: 2 }

  validates :role, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true
end
