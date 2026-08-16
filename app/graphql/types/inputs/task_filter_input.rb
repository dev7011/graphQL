# frozen_string_literal: true

module Types
  module Inputs
    class TaskFilterInput < Types::BaseInputObject
      argument :status,
               [Types::Enums::TaskStatusEnum],
               required: false

      argument :priority,
               [Types::Enums::TaskPriorityEnum],
               required: false

      argument :assignee_id,
               ID,
               required: false

      argument :unassigned,
               Boolean,
               required: false

      argument :due_from,
               GraphQL::Types::ISO8601Date,
               required: false

      argument :due_to,
               GraphQL::Types::ISO8601Date,
               required: false

      argument :overdue,
               Boolean,
               required: false

      argument :search,
               String,
               required: false
    end
  end
end