module Resolvers
  module Tasks
    class TasksResolver < BaseResolver
      type [Types::Tasks::TaskType], null: false

      argument :project_id, ID, required: true
      argument :status, Types::Enums::TaskStatusEnum, required: false
      argument :priority, Types::Enums::TaskPriorityEnum, required: false
      argument :search, String, required: false

      def resolve(
        project_id:,
        status: nil,
        priority: nil,
        search: nil
      )
        authenticate_user!

        project = find_project!(project_id)

        authorize!(project, :show)

        scope = project.tasks

        scope = filter_status(
          scope,
          status
        )

        scope = filter_priority(
          scope,
          priority
        )

        scope = filter_search(
          scope,
          search
        )

        scope.order(
          created_at: :desc
        )
      end

      private

      def find_project!(id)
        Project.find_by(id: id) ||
          raise(
            GraphQL::ExecutionError,
            "Project not found"
          )
      end

      def filter_status(scope, status)
        return scope if status.blank?

        scope.where(
          status: status
        )
      end

      def filter_priority(scope, priority)
        return scope if priority.blank?

        scope.where(
          priority: priority
        )
      end

      def filter_search(scope, search)
        return scope if search.blank?

        term =
          "%#{Task.sanitize_sql_like(search)}%"

        scope.where(
          "tasks.title ILIKE :term OR tasks.description ILIKE :term",
          term: term
        )
      end
    end
  end
end