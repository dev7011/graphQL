module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include Authenticatable
    include Authorizable
  end
end
