module Authorizable
  private

  def authorize!(record, action, user: nil)
    model_name = record.is_a?(Class) ? record.name : record.class.name

    policy_name = "#{model_name}Policy".safe_constantize

    policy_name.new(user, record).public_send(action)
  rescue NameError
    raise GraphQL::ExecutionError, "No policy found for #{record.class.name}"
  end
end