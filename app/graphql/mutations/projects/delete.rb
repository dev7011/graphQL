# frozen_string_literal: true

module Mutations
  module Projects
    class Delete < BaseMutation
      # Define the input fields for the mutation
      argument :id, ID, required: true

      field :project, Types::ProjectType, null: true
      field :errors, [String], null: false
      field :informations, [String], null: false

      def resolve(id:)
        authenticate_user!

        project = find_project!(id)

        authorize!(project, :destroy)

        deleted_project_id = project.id

        if project.destroy
          {
            success: true,
            deleted_project_id: deleted_project_id,
            errors: []
          }
        else
          {
            success: false,
            deleted_project_id: nil,
            errors: project.errors.full_messages
          }
        end
      end
    end
  end
end
