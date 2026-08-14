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

        project = find_project!(project_id)
        authorize!(project, :manage_members)

        user = User.find_by(id: user_id)

        ::Projects::RemoveMember
                           .new(project: project, user: user)
                           .call
      end
    end
  end
end