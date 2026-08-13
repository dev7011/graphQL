class TaskPolicy < BasePolicy
  def initialize(user, record)
    super(user, record)
  end

  private

  def member?
    true
  end
end