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

  has_many :tasks,
    dependent: :destroy

  validates :status,
    presence: true

  def owner?(user)
    owner_id == user.id
  end

  def member?(user)
    project_members.exists?(
      user_id: user.id
    )
  end

  def includes_user?(user)
    owner?(user) || member?(user)
  end

end
