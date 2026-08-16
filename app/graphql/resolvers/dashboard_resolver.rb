module Resolvers
  class DashboardResolver < BaseResolver
    type Types::DashboardType, null: true

    def resolve
      {
        total_projects: 1,
        totalAssignedTasks: 2,
        todoCount: 3,
        inProgressCount: 4,
        doneCount: 5,
        overdueCount: 6
      }
    end

  end
end