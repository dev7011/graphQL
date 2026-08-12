# frozen_string_literal: true

module Resolvers
  class ProjectsResolver < BaseResolver
    # [Types::ProjectType]: ist Array von ProjectType,
    # null: true bedeutet, dass das Feld ein Array von ProjectType-Objekten zurückgibt und null sein kann.
    #
    type [Types::ProjectType], null: true

    def resolve
      user = authenticate_user!

      return Project.all if user.admin?

      Project
        .left_joins(:project_members)
        .where(
          "projects.owner_id = :user_id OR project_members.user_id = :user_id",
          user_id: user.id
        )
        .distinct
    end
  end
end
