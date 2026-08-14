module Errors
  class GraphqlError < GraphQL::ExecutionError
    def initialize(message, code:)
      super(message, extensions: { code: code })
    end
  end
end