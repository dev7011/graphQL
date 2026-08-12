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
        user = authenticate_user!

        project = find_project!(id)

        policy = ProjectPolicy.new(user, project)
        unless policy.destroy?
          raise GraphQL::ExecutionError,
                "Not authorized to delete this project"
        end

        if project.destroy
          {
            project: project,
            informations: ["Project was successfully deleted"]
          }
        else
          {
            project: project,
            errors: project.errors.full_messages
          }
        end
      end
    end
  end
end
