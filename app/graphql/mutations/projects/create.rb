# frozen_string_literal: true

module Mutations
  module Projects
    class Create < BaseMutation
      # Define the input fields for the mutation
      argument :name, String, required: true
      argument :description, String, required: false
      argument :status, Integer, required: true
      argument :owner_id, Integer, required: true

      field :project, Types::Projects::ProjectType, null: true
      field :errors, [String], null: false

      def resolve(name: nil, description: nil, status: nil, owner_id: nil)
        project = Project.new(
          name: name,
          status: status,
          description: description,
          owner: User.find_by(id: owner_id)
        )

        if project.save
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
