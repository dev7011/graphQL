module Resolvers
  module Users
    class CurrentUserResolver < BaseResolver
      type Types::Users::CurrentUserType, null: true

      def resolve
        authenticate_user!

        {
          user: current_user,
          assigned_tasks: current_user.assigned_tasks,
          project_memberships: current_user.project_members,
          projects: current_user.projects
        }
      end
    end
  end
end