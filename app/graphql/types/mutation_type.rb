# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # mapping of mutation names with create_project
    field :create_project, mutation: Mutations::Projects::Create, null: false do
      description "Create a new project"
    end

    field :update_project, mutation: Mutations::Projects::Update, null: false do
      description "Update an existing project"
    end

    field :delete_project, mutation: Mutations::Projects::Delete, null: false do
      description "Delete an existing project"
    end
  end
end
