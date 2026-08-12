module Mutations
  module Projects
    class RemoveProjectMember < Mutations::BaseMutation
      argument :project_id, ID, required: true
      argument :user_id, ID, required: true

      field :success, Boolean, null: false
      field :removed_user_id, ID, null: true
      field :errors, [String], null: false

      def resolve(project_id:, user_id:)
        authenticate_user!

        project = Project.find_by(id: project_id)

        unless project
          raise GraphQL::ExecutionError,
                "Project not found"
        end

        authorize!(project, :manage_members)

        if project.owner_id.to_s == user_id.to_s
          return {
            success: false,
            removed_user_id: nil,
            errors: ["Project owner cannot be removed"]
          }
        end

        project_member =
          project.project_members.find_by(
            user_id: user_id
          )

        unless project_member
          return {
            success: false,
            removed_user_id: nil,
            errors: ["Project member not found"]
          }
        end

        removed_user_id = project_member.user_id

        if project_member.destroy
          {
            success: true,
            removed_user_id: removed_user_id,
            errors: []
          }
        else
          {
            success: false,
            removed_user_id: nil,
            errors: project_member.errors.full_messages
          }
        end
      end
    end
  end
end