module Authorizable

  private

  def authorize!(record, action, user: nil)
    policy_class = "#{record.class.name}Policy".safe_constantize
    policy = policy_class.new(user, record)

    return true if policy.public_send(action)

    raise GraphQL::ExecutionError, "Not authorized to #{action} this #{record.class.name.downcase}"
  end

end