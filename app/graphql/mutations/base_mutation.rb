# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Authenticatable
    include Authorizable

    private

    def find_project!(id)
      Project.find_by(id: id) ||
        raise(
          GraphQL::ExecutionError,
          "Project not found"
        )
    end

    def find_model!(model, id)
      model.find_by(id: id) ||
        raise(
          GraphQL::ExecutionError,
          "#{model.name} not found"
        )
    end
  end
end
