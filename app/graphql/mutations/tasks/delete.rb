module Mutations
  module Tasks
    class Delete < BaseMutation
      # Avoid duplicate GraphQL mutation names
      graphql_name "DeleteTask"

      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :deleted_id, ID, null: true
      field :errors, [String], null: false

      def resolve(id:)
        authenticate_user!

        task = find_task!(id)

        authorize!(task, :destroy)

        deleted_task_id = task.id

        if task.destroy
          {
            success: true,
            deleted_id: deleted_task_id,
            errors: []
          }
        else
          {
            success: false,
            deleted_id: nil,
            errors: task.errors.full_messages
          }
        end
      end
    end
  end
end