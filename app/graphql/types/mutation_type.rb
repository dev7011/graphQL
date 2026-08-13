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

    field :add_project_member, mutation: Mutations::Projects::AddProjectMember, null: false do
      description "Add a member to a project"
    end

    field :remove_project_member, mutation: Mutations::Projects::RemoveProjectMember, null: false do
      description "Remove a member from a project"
    end

    # Task
    field :createTask, mutation: Mutations::Tasks::Create, null: false do
      description "Create a new task"
    end

    field :updateTask, mutation: Mutations::Tasks::Update, null: false
    field :deleteTask, mutation: Mutations::Tasks::Delete, null: false
  end
end
