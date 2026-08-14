# frozen_string_literal: true

module Mutations
  module Tasks
    class Update < BaseMutation
      # FIX Problem mit duplication name Update (projects/tasks)
      graphql_name "UpdateTask"

      # Define the input fields for the mutation
      argument :id, ID, required: true
      argument :attributes, Types::Inputs::TaskUpdateInput, required: true

      field :task, Types::TaskType, null: true
      field :errors, [String], null: false

      def resolve(id:, attributes:)
        authenticate_user!

        task = find_task!(id)

        authorize!(task, :update)

        if task.update(attributes.to_h)
          {
            task: task,
            errors: []
          }
        else
          {
            task: nil,
            errors: task.errors.full_messages
          }
        end
      end
    end
  end
end
