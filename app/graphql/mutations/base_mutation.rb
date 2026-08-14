# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include GraphqlAuthorization

    private

    def current_user
      context[:current_user]
    end

    def find_record!(model, id)
      model.find_by(id: id) || not_found!(model.name)
    end
  end
end