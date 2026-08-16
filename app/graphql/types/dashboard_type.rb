module Types
  class DashboardType < Types::BaseObject
    field total_projects, Integer, null: false
    field :totalAssignedTasks, Integer, null: false
    field :todoCount, Integer, null: false
    field :inProgressCount, Integer, null: false
    field :doneCount, Integer, null: false
    field :overdueCount, Integer, null: false
  end
end