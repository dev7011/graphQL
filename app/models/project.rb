class Project < ApplicationRecord
  enum status: {
    active: 0,
    archived: 1,
    completed: 2
  }

  belongs_to :owner,
    class_name: "User",
    inverse_of: :owned_projects

  has_many :project_members,
    dependent: :destroy

  has_many :members,
    through: :project_members,
    source: :user

  validates :status,
    presence: true

end
