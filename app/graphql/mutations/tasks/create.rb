module Mutations
  module Tasks
    class Create < Mutations::BaseMutation
      graphql_name "CreateTask"

      argument :project_id, ID, required: true
      argument :attributes, Types::Inputs::TaskInput, required: true

      field :task, Types::TaskType, null: true
      field :errors, [String], null: false

      def resolve(project_id:, attributes:)
        authenticate_user!

        project = find_project!(project_id)
        authorize_with!(TaskPolicy, project, :create)

        task = ::Tasks::Create.new(project, attributes).call
        if task.persisted?
          { task: task, errors: [] }
        else
          {
            task: [],
            errors: task.errors.full_messages
          }
        end
      end
    end
  end
end