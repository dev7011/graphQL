# frozen_string_literal: true

module Resolvers
  class TaskResolver < BaseResolver
    type Types::TaskType, null: true
    argument :id, ID, required: true

    def resolve(id: )
      authenticate_user!

      find_record!(Task, id)
    end
  end
end
