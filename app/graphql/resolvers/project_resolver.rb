# frozen_string_literal: true

module Resolvers
  class ProjectResolver < BaseResolver
    type Types::ProjectType, null: true

    argument :id, ID, required: true

    def resolve(id: )
      authenticate_user!

      Project.find_by(id: id)
    end
  end
end
