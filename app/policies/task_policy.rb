class TaskPolicy
  # [Pundit convention]
  attr_reader :user, :record

  # [Pundit convention]
  def initialize(user, record)
    @user = user
    @record = record
  end

  # [Business rule]
  def show?
    project_policy.show?
  end

  # [Business rule]
  def update?
    admin? || owner? || editable_member?
  end

  # [Business rule]
  def assign?
    admin? || owner? || editable_member?
  end

  # [Business rule]
  def destroy?
    admin? || owner? || project_manager?
  end

  private

  def project
    record.project
  end

  def project_policy
    ::ProjectPolicy.new(user, project)
  end

  def admin?
    user.admin?
  end

  def owner?
    project.owner?(user)
  end

  def member?
    project.member?(user)
  end


  def editable_member?
    return false unless user.user?

    project.project_role?(user, :manager) ||
      project.project_role?(user, :developer)
  end

  def project_manager?
    project.project_role?(
      user,
      :manager
    )
  end
end