module Types
  class DashboardType < Types::BaseObject
    field :total_projects, Integer, null: false
    field :total_assigned_tasks, Types::Tasks::TaskType.connection_type, null: false
    field :todo_count, Integer, null: false
    field :in_progress_count, Integer, null: false
    field :done_count, Integer, null: false
    field :overdue_count, Integer, null: false
  end
end