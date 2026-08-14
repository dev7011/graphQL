module Authenticatable

  private

  def current_user
    context[:current_user]
  end

  def authenticate_user!
    return current_user if current_user

    raise GraphQL::ExecutionError,
          "Authentication required"
  end
end