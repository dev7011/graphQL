# frozen_string_literal: true

module Resolvers
  class ProjectsResolver < BaseResolver
    # [Types::ProjectType]: ist Array von ProjectType,
    # null: true bedeutet, dass das Feld ein Array von ProjectType-Objekten zurückgibt und null sein kann.
    #
    type [Types::ProjectType], null: true

    def resolve
      authenticate_user!

      Project.all
    end
  end
end
