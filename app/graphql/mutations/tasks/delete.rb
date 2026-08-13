# frozen_string_literal: true

module Mutations
  module Tasks
    class Delete < BaseMutation
      # FIX Problem mit duplication name Delete (projects/tasks)
      graphql_name "DeleteTask"

      # Define the input fields for the mutation
      argument :id, ID, required: true

      field :task, Types::TaskType, null: true
      field :flashes, [String], null: false

      def resolve(id:)
        user = authenticate_user!

        task = find_model!(Task, id)

        authorize!(task, :destroy?, user: user)

        if task.destroy
          {
            task: task,
            flashes: ["task was successfully deleted"]
          }
        else
          {
            task: task,
            flashes: task.errors.full_messages
          }
        end
      end
    end
  end
end
