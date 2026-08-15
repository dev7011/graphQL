module Types
  module Tasks
    class TaskResultType < Types::BaseObject
      field :item_count, Integer, null: true
      field :high_count, Integer, null: true
      field :tasks, [Types::Tasks::TaskType], null: false
      end
  end
end