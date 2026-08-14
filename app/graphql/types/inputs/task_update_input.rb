module Types
  module Inputs
    class TaskUpdateInput < Types::BaseInputObject
      argument :title, String, required: false
      argument :description, String, required: false
      argument :status, Types::Enums::TaskStatusEnum, required: false
      argument :priority, Types::Enums::TaskPriorityEnum, required: false
    end
  end
end