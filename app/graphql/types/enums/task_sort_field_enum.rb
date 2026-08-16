module Types
  module Enums
    class TaskSortFieldEnum < Types::BaseEnum
      value "CREATED_AT", value: "created_at"
      value "UPDATED_AT", value: "updated_at"
      value "DUE_DATE", value: "due_date"
      value "TITLE", value: "title"
      value "PRIORITY", value: "priority"
    end
  end
end