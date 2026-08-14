# frozen_string_literal: true

module Mutations
  module Tasks
    class Delete < BaseMutation
      # FIX Problem mit duplication name Delete (projects/tasks)
      graphql_name "DeleteTask"

      # Define the input fields for the mutation
      argument :id, ID, required: true

      field :task, Types::TaskType, null: true
      field :errors, [String], null: false

      def resolve(id:)
        authenticate_user!

        task = find_task!(id)

        authorize!(task, :destroy)

        deleted_task_id = task.id

        if task.destroy
          {
            success: true,
            deleted_task_id: deleted_task_id,
            errors: []
          }
        else
          {
            success: false,
            deleted_task_id: nil,
            errors: task.errors.full_messages
          }
        end
      end
    end
  end
end
