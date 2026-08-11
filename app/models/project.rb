class Project < ApplicationRecord
  enum status: {
    active: 0,
    archived: 1,
    completed: 2
  }

  belongs_to :owner,
    class_name: "User",
    inverse_of: :owned_projects

  validates :status,
    presence: true

end
