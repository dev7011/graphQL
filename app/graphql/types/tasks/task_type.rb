module Types
  module Tasks
    class TaskType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :description, String, null: true

      field :status, Types::Enums::TaskStatusEnum, null: false
      field :priority, Types::Enums::TaskPriorityEnum, null: false
      field :due_date, GraphQL::Types::ISO8601Date, null: true
      field :project, Types::Projects::ProjectType, null: false
      field :assignee, Types::UserType, null: true

      def assignee
        dataload_association(object, :assignee)
      end

      def project
        dataload_association(object, :project)
      end

    end
  end
end