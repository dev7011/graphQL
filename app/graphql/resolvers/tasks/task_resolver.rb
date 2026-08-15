module Resolvers
  module Tasks
    class TaskResolver < BaseResolver
      type Types::Tasks::TaskType, null: false

      argument :id, ID, required: true

      def resolve(
        project_id:,
        status: nil,
        priority: nil,
        search: nil
      )
        authenticate_user!

        project = find_project!(project_id)

        authorize_read!(project)

        scope = project.tasks
        scope = filter_status(scope, status)
        scope = filter_priority(scope, priority)
        scope = filter_search(scope, search)

        scope.order(
          created_at: :desc,
          id: :desc
        )
      end
    end
  end
end