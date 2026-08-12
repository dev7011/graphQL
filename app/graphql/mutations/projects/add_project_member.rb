module Mutations
  module Projects
    class AddProjectMember < Mutations::BaseMutation
      argument :project_id, ID, required: true
      argument :user_id, ID, required: true

      field :project_member, Types::ProjectMemberType, null: true
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

        if project.owner_id == user.id
          return {
            project_member: nil,
            errors: ["Project owner cannot be added as a member"]
          }
        end

        existing_member =
          project.project_members.find_by(
            user_id: user.id
          )

        if existing_member
          return {
            project_member: nil,
            errors: ["User is already a project member"]
          }
        end

        project_member =
          project.project_members.new(
            user: user
          )

        if project_member.save
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
      end
    end
  end
end