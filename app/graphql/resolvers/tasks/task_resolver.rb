module Resolvers
  module Tasks
    class TaskResolver < BaseResolver
      type Types::Tasks::TaskType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        authenticate_user!

        task = find_task!(id)

        authorize!(task, :show)

        task
      end

      private

      def find_task!(id)
        Task.find_by(id: id) ||
          raise(
            GraphQL::ExecutionError,
            "Task not found"
          )
      end
    end
  end
end