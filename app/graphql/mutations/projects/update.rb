# frozen_string_literal: true

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
        user = authenticate_user!

        project = Project.find_by(id: id)

        if project.blank?
          raise GraphQL::ExecutionError, "Project not found"
        end

        policy = ProjectPolicy.new(user, project)

        unless policy.update?
          raise GraphQL::ExecutionError,
                "Not authorized to update this project"
        end

        project.assign_attributes(attributes)

        if project.save
          {
            project: project,
            errors: []
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
