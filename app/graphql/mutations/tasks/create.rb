# frozen_string_literal: true

module Mutations
  module Tasks
    class Create < BaseMutation
      # FIX Problem mit duplication name create (projects/tasks)
      graphql_name "CreateTask"

      # Define the input fields for the mutation
      argument :title, String, required: true
      argument :description, String, required: false
      argument :status, String, required: true
      argument :priority, String, required: true

      argument :assignee_id, Integer, required: false
      argument :project_id, Integer, required: true

      field :task, Types::TaskType, null: true
      field :flashes, [String], null: false

      def resolve(**attributes)
        authenticate_user!

        task = Task.new(attributes)
        if task.save
          {
            task: task,
            flashes: []
          }
        else
          {
            task: nil,
            flashes: task.errors.full_messages
          }
        end
      end
    end
  end
end
