# frozen_string_literal: true

module Mutations
  module Tasks
    class Update < BaseMutation
      # FIX Problem mit duplication name Update (projects/tasks)
      graphql_name "UpdateTask"

      # Define the input fields for the mutation
      argument :id, ID, required: true
      argument :title, String, required: true
      argument :description, String, required: false
      argument :status, String, required: true
      argument :priority, String, required: true

      argument :assignee_id, Integer, required: false
      argument :project_id, Integer, required: true

      field :task, Types::TaskType, null: true
      field :flashes, [String], null: false

      def resolve(id:, **attributes)
        user = authenticate_user!

        task = find_model!(Task, id)

        authorize!(task, :update?, user: user)

        task.assign_attributes(attributes)

        if task.save
          {
            task: task,
            flashes: []
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
