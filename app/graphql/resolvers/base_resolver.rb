module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include Authenticatable
    include Authorizable
    include ModelHelpers

    private

    def authenticate_user!
      return current_user if current_user

      raise Errors::GraphqlError.new(
        "Authentication required",
        code: "UNAUTHENTICATED"
      )
    end

    def not_found!(resource = "Resource")
      raise Errors::GraphqlError.new(
        "#{resource} not found",
        code: "NOT_FOUND"
      )
    end

    def forbidden!
      raise Errors::GraphqlError.new(
        "Not authorized",
        code: "FORBIDDEN"
      )
    end
  end
end
