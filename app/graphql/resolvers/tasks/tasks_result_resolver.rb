# frozen_string_literal: true

module Resolvers
  module Tasks
    class TasksResultResolver < BaseResolver
    type Types::Tasks::TaskResultType, null: false
    
    argument :assignee_id, ID, required: false
    argument :status, Types::Enums::TaskStatusEnum, required: false
    argument :search, String, required: false

    def resolve(assignee_id: nil, status: nil, search: nil)
      user = authenticate_user!

      authorize!(Task, :show?, user: user)

      scope = Task.all
      scope = scope.where(assignee_id: assignee_id) if assignee_id
      scope = scope.where(status: status) if status
      scope = scope.where("title ILIKE :search OR description ILIKE :search ", search: "%#{search}%") if search.present?

      scope

      {
        item_count: scope.count,
        high_count: scope.where(priority: "high").count,
        tasks: scope
      }
    end
    end
  end
end
