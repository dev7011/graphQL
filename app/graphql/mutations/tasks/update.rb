# frozen_string_literal: true

module Mutations
  module Tasks
    class Update < BaseMutation
      # FIX Problem mit duplication name Update (projects/tasks)
      graphql_name "UpdateTask"

      # Define the input fields for the mutation
      argument :task_id, ID, required: true
      argument :attributes, Types::Inputs::TaskUpdateInput, required: true

      field :task, Types::TaskType, null: true
      field :errors, [String], null: false

      def resolve(task_id:, attributes:)
        user = authenticate_user!

        task = find_record!(Task, task_id)
        authorize_resource!(task, :update?, user: user)

        task.assign_attributes(attributes.to_h)
        if task.save
          {
            task: task,
            errors: []
          }
        else
          {
            task: task,
            errors: task.errors.full_messages
          }
        end
      end
    end
  end
end
