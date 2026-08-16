module Resolvers
  module Users
    class CurrentUserResolver < BaseResolver
      type Types::Users::CurrentUserType, null: true

      def resolve
        user = authenticate_user!

        {
          user: user,
          projects: projects_for(user),
          assigned_tasks: assigned_tasks_for(user),
          project_memberships: project_memberships_for(user)
        }
      end

      private

      def projects_for(user)
        ::ProjectPolicy::Scope
          .new(user, Project)
          .resolve
          .order(
            created_at: :desc,
            id: :desc
          )
      end

      def assigned_tasks_for(user)
        ::TaskPolicy::Scope
          .new(user, Task)
          .resolve
          .where(
            assignee_id: user.id
          )
          .order(
            created_at: :desc,
            id: :desc
          )
      end

      def project_memberships_for(user)
        user
          .project_members
          .includes(:project)
          .order(
            created_at: :desc,
            id: :desc
          )
      end
    end
  end
end