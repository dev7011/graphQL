module Mutations
  module Projects
    class AddProjectMember < Mutations::BaseMutation
      argument :project_id, ID, required: true
      argument :user_id, ID, required: true

      field :project_member, Types::Projects::ProjectMemberType, null: true
      field :errors, [String], null: false

      def resolve(project_id:, user_id:)
        authenticate_user!

        project = find_project!(project_id)

        authorize!(project, :manage_members)

        user = User.find_by(id: user_id)

        unless user
          return {
            project_member: nil,
            errors: ["User not found"]
          }
        end

        project_member = ::Projects::AddMember
                           .new(project: project, user: user)
                           .call

        if project_member.persisted?
          {
            project_member: project_member,
            errors: []
          }
        else
          {
            project_member: nil,
            errors: project_member.errors.full_messages
          }
        end
      rescue ArgumentError => e
        {
          project_member: nil,
          errors: [e.message]
        }
      end
    end
  end
end