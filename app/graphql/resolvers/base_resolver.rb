module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include GraphqlAuthorization
  end
end
