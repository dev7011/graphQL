module Errors
  class AuthorizeError < GraphqlError
    private

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

    def authorize_resource!(resource, action, user: nil)
      model_name = resource.is_a?(Class) ? resource.name : resource.class.name
      policy_name = "#{model_name}Policy".safe_constantize

      policy_name.new(user, resource).public_send(action)

    rescue NameError
      not_found!(resource)
    end
  end
end