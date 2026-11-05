# frozen_string_literal: true

module Mutations
  module Projects
    class Delete < BaseMutation
      # Define the input fields for the mutation
      argument :id, ID, required: true

      field :errors, [String], null: false
      field :success, Boolean, null: false
      field :deleted_project_id, [String], null: false

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
