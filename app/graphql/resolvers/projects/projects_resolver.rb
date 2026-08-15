# frozen_string_literal: true

module Resolvers
  module Projects
    class ProjectsResolver < BaseResolver
      type Types::Projects::ProjectType.connection_type, null: true

      def resolve
        user = authenticate_user!

        ::ProjectPolicy::Scope
          .new(user, ::Project.all) # such Model von Root
          .resolve
      end
    end
  end
end
