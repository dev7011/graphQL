module Resolvers
  module Projects
    class ProjectResolver < BaseResolver
      type Types::Projects::ProjectType,
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
end