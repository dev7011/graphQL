# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, null: true, description: "Fetches an object given its ID." do
      type NodeType
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

    field :current_user, resolver: Resolvers::Users::CurrentUserResolver, null: true do
      description "Returns the currently authenticated user"
    end

    field :test, resolver: Resolvers::TestResolver, null: true do
      description "Returns the currently authenticated user via TestResolver"
    end

    field :projects, resolver: Resolvers::Projects::ProjectsResolver, null: true
    field :project, resolver: Resolvers::Projects::ProjectResolver, null: true

    field :project_member, null: true do
      type Projects::ProjectMemberType
      description "Returns the currently authenticated user"
    end

    field :assignees, [Types::Tasks::TaskType], null: true do
      description "Returns a list of tasks"
    end

    field :task, resolver: Resolvers::Tasks::TaskResolver, null: true do
      description "Returns a task by ID"
      argument :id, ID, required: true
    end

    field :tasks, resolver: Resolvers::Tasks::TasksResolver, null: true do
      description "Returns a list of tasks"
    end

    field :tasks_pagination, resolver: Resolvers::Tasks::TasksPaginationResolver, null: true do
      description "Returns a paginated list of tasks"
    end

    field :tasks_result, resolver: Resolvers::Tasks::TasksResultResolver, null: true do
      description "Returns a list of tasks with result"
    end
  end
end
