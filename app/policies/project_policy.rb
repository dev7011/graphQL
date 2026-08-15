class ProjectPolicy
  # [Pundit convention]
  attr_reader :user, :record

  # [Pundit convention]
  def initialize(user, record)
    @user = user
    @record = record
  end

  # [Business rule]
  def show?
    admin? || owner? || member? || manager?
  end

  # [Business rule]
  def update?
    admin? || owner? || manager?
  end

  # [Business rule]
  def destroy?
    admin? || owner? || manager?
  end

  # [Business rule]
  def manage_members?
    admin? || owner? || manager?
  end

  # [Business rule]
  def create_task?
    admin? || owner? || writable_member?
  end

  private

  def admin?
    user.admin?
  end

  def owner?
    record.owner_id == user.id
  end

  def member?
    record.project_members.exists?(user_id: user.id)
  end

  def writable_member?
    return false unless user.user?

    record.project_role?(user, :manager) ||
      record.project_role?(user, :developer)
  end

  def manager?
    record.project_role?(user, :manager)
  end


  # [Pundit convention]
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.all if user.admin?

      scope
        .left_joins(:project_members)
        .where(
          "projects.owner_id = :user_id OR project_members.user_id = :user_id",
          user_id: user.id
        )
        .distinct
    end
  end
end