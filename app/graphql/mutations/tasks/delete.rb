# frozen_string_literal: true

module Mutations
  module Tasks
    class Delete < BaseMutation
      # Define the input fields for the mutation
      argument :id, ID, required: true

      field :task, Types::ProjectType, null: true
      field :flashes, [String], null: false

      def resolve(id:)
        user = authenticate_user!

        task = find_model!(Task, id)
        authorize!(task, :destroy?, user: user)

        if task.destroy
          {
            task: task,
            flashes: ["Project was successfully deleted"]
          }
        else
          {
            task: task,
            flashes: project.errors.full_messages
          }
        end
      end
    end
  end
end
