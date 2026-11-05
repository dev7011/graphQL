
# frozen_string_literal: true

module GraphqlAuthorization
  private

  def current_user
    context[:current_user]
  end

  def authenticate_user!
    current_user || raise(
      Errors::GraphqlError.new(
        "Authentication required",
        code: "UNAUTHENTICATED"
      )
    )
  end

  def find_project!(id)
    Project.find_by(id: id) || not_found!("Project")
  end

  def find_task!(id)
    Task.find_by(id: id) || not_found!("Task")
  end

  # Generic Pundit authorization
  def authorize!(record, action)
    policy = policy_for(record)
    authorize_policy!(policy, record, action)
  end

  # Hide resource existence when access is denied
  def authorize_read!(record)
    policy = policy_for(record)

    return record if policy.show?

    not_found!(record.class.name)
  end

  # Explicit policy authorization
  def authorize_with!(policy_class, record, action)
    policy = policy_class.new(current_user, record)
    authorize_policy!(policy, record, action)
  end

  # Resolve records through Pundit Scope
  def policy_scope!(scope)
    policy_class = policy_class_for(scope)

    unless policy_class.const_defined?(:Scope, false)
      raise ArgumentError,
            "Scope not found for #{policy_class}"
    end

    policy_class::Scope.new(current_user, scope).resolve
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
    policy_class = policy_class_for(record)
    policy_class.new(current_user, record)
  end

  def policy_class_for(record)
    model_name =
      record.is_a?(Class) ? record.name : record.class.name

    policy_class_name = "#{model_name}Policy"
    policy_class = policy_class_name.safe_constantize

    unless policy_class && policy_class <= ApplicationPolicy
      raise ArgumentError,
            "Invalid or missing policy: #{policy_class_name}"
    end

    policy_class
  end

  def authorize_policy!(policy, record, action)
    method_name = "#{action}?"

    unless policy.respond_to?(method_name)
      raise ArgumentError,
            "Unknown policy action: #{method_name}"
    end

    return record if policy.public_send(method_name)

    forbidden!
  end
end
