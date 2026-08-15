# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :role, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :assigned_tasks, Types::Tasks::TaskType.connection_type, null: false
    field :assigned_tasks_counter, Integer, null: false

    def assigned_tasks_counter
      object.assigned_tasks.count
    end
  end
end
