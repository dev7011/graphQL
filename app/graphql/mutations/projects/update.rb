
module Mutations
  module Projects
    class Update < BaseMutation

      # Define the input fields for the mutation
      argument :id, ID, required: true
      argument :name, String, required: true
      argument :description, String, required: false
      argument :status, Integer, required: false
      argument :owner_id, Integer, required: false

      field :project, Types::ProjectType, null: true
      field :errors, [String], null: false

      def resolve(id:, **attributes)
        authenticate_user!

        project = find_project!(id)

        authorize!(project, :update)

        if project.update(attributes)
          {
            project: project,
            errors: []
          }
        else
          {
            project: nil,
            errors: project.errors.full_messages
          }
        end
      end
    end
  end
end
