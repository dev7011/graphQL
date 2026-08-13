module Types
  module Enums
    class TaskStatusEnum < Types::BaseEnum
      value "TODO",
            value: "todo"

      value "IN_PROGRESS",
            value: "in_progress"

      value "DONE",
            value: "done"
    end
  end
end