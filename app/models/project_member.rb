class ProjectMember < ApplicationRecord
  ROLES = %w[manager developer viewer].freeze

  belongs_to :project
  belongs_to :user

  validates :role,
            inclusion: { in: ROLES }

  validates :user_id,
    uniqueness: {
      scope: :project_id
    }

end
