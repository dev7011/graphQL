# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :current_user, Types::UserType, null: true do
      description "Returns the currently authenticated user"
    end

    def current_user
      context[:current_user]
    end
    field :test, resolver: Resolvers::TestResolver, null: true do
      description "Returns the currently authenticated user via TestResolver"
    end

    field :projects, resolver: Resolvers::ProjectsResolver, null: true
    field :project, resolver: Resolvers::ProjectResolver, null: true

    field :project_member, Types::ProjectMemberType, null: true do
      description "Returns the currently authenticated user"
    end

    field :assignees, [Types::TaskType], null: true do
      description "Returns a list of tasks"
    end

    field :task, resolver: Resolvers::TaskResolver, null: true do
      description "Returns a task by ID"
      argument :id, ID, required: true
    end

  end
end
