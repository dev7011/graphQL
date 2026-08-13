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

    def authorize!(record, action, user: nil)
      policy = ProjectPolicy.new(user, record)
      return true if policy.public_send("#{action}?")

      raise GraphQL::ExecutionError, "Not authorized to delete this #{record.class.name.downcase}"
    end
  end
end
