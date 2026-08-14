module Resolvers
  class ProjectResolver < BaseResolver
    type Types::ProjectType,
         null: false

    argument :id,
             ID,
             required: true

    def resolve(id:)
      authenticate_user!

      project = find_project!(id)

      authorize_read!(project)
    end
  end
end