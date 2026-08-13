# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Authenticatable
    include Authorizable
    include ModelHelpers

  end
end
