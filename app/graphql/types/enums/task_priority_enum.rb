module Types
  module Enums
    class TaskPriorityEnum < Types::BaseEnum
      value "LOW",
            value: "low"

      value "MEDIUM",
            value: "medium"

      value "HIGH",
            value: "high"
    end
  end
end