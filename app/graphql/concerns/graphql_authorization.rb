module GraphqlAuthorization
  private

  def current_user
    context[:current_user]
  end

  def authenticate_user!
    return current_user if current_user

    raise Errors::GraphqlError.new(
      "Authentication required",
      code: "UNAUTHENTICATED"
    )
  end

  def find_project!(id)
    Project.find_by(id: id) ||
      not_found!("Project")
  end

  def find_task!(id)
    Task.find_by(id: id) ||
      not_found!("Task")
  end

  def authorize!(record, action)
    policy = policy_for(record)

    return record if policy.public_send("#{action}?")

    forbidden!
  end

  def authorize_read!(record)
    policy = policy_for(record)

    return record if policy.show?

    not_found!(record.class.name)
  end

  def authorize_with!(policy_class, record, action)
    policy = policy_class.new(
      current_user,
      record
    )

    return record if policy.public_send("#{action}?")

    forbidden!
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

  def policy_for(record)
    model_name = record.is_a?(Class) ? record.name : record.class.name
    policy_class  = "#{model_name}Policy".constantize

    policy_class.new(current_user, record)

  rescue NameError
    raise ArgumentError, "Policy not found for #{policy_class}"
  end
end