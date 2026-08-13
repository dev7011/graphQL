class Task < ApplicationRecord
  belongs_to :project

  belongs_to :assignee,
    class_name: "User",
    foreign_key: :assignee_id,
    inverse_of: :assigned_tasks

  validates :title,
    presence: true

  validates :status,
    presence: true,
    inclusion: {
      in: %w[todo in_progress done]
    }

  validates :priority,
    presence: true,
    inclusion: {
      in: %w[low medium high]
    }
end