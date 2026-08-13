module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :status, String, null: false
    field :priority, String, null: false

    field :project, Types::ProjectType, null: false
    field :assignee, Types::UserType, null: true

  end
end