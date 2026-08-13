module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include Authenticatable
    include Authorizable
    include ModelHelpers

  end
end
