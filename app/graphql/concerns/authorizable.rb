module Authorizable

  private

  def authorize!(record, action)
    policy = policy_for(record)

    return if policy.public_send("#{action}?")

    raise GraphQL::ExecutionError,
          "Not authorized"
  end

  def policy_for(record)
    case record
    when Project
      ProjectPolicy.new(current_user, record)
    else
      raise ArgumentError,
            "Policy not found for #{record.class}"
    end
  end
end