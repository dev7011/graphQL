module Types
  module Inputs
    class TaskInput < Types::BaseInputObject
      argument :title, String, required: true
      argument :description, String, required: false
      argument :status, Types::Enums::TaskStatusEnum, required: false
      argument :priority, Types::Enums::TaskPriorityEnum, required: false
      argument :due_date, GraphQL::Types::ISO8601Date, required: false
      argument :assignee_id, ID, required: false
    end
  end
end