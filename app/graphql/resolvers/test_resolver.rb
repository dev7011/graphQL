# frozen_string_literal: true

module Resolvers
  class TestResolver < BaseResolver
    type Types::UserType, null: true

    def resolve
      authenticate_user!
    end
  end
end
