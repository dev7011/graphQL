module Types
  module Projects
    class ProjectMemberType < Types::BaseObject
      field :id, ID, null: false
      field :project_id, ID, null: false
      field :user_id, ID, null: false
      field :role, Types::Enums::ProjectMemberRoleEnum, null: false

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end