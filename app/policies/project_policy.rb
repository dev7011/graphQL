
# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy

  def show?
    admin? || owner? || member? || manager?
  end

  def update?
    admin? || owner? || manager?
  end

  def destroy?
    admin? || owner?
  end

  def manage_members?
    admin? || owner? || manager?
  end

  def create_task?
    admin? || owner? || writable_member?
  end

  private

  def owner?
    record.owner_id == user.id
  end

  def member?
    record.project_members.exists?(user_id: user.id)
  end

  def manager?
    record.project_role?(user, :manager)
  end

  def writable_member?
    return false unless user.user?

    record.project_role?(user, :manager) ||
      record.project_role?(user, :developer)
  end

  class Scope < ApplicationPolicy::Scope

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
