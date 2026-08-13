module Types
  class TaskResultType < Types::BaseObject
    field :item_count, Integer, null: true
    field :high_count, Integer, null: true
    field :tasks, [Types::TaskType], null: false
  end
end