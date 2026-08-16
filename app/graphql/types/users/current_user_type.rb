# frozen_string_literal: true

module Types
  module Users
    class CurrentUserType < Types::BaseObject
      field :user, Types::UserType, null: true
      field :assigned_tasks, Types::Tasks::TaskType.connection_type, null: true
      field :project_memberships, Types::Projects::ProjectMemberType.connection_type, null: true
      field :projects, Types::Projects::ProjectType.connection_type, null: true

    end
  end
end
