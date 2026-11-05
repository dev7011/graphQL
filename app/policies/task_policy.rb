
# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy

  def initialize(user, record)
    super(user, record)

    if record.is_a?(Task)
      @task = record
      @project = record.project
    else
      @project = record
    end
  end

  def show?
    admin? || project_owner? || project_member?
  end

  def create?
    admin? || project_owner? || manager? || developer?
  end

  def update?
    admin? || project_owner? || manager? || developer?
  end

  def assign?
    admin? || project_owner? || manager? || developer?
  end

  def destroy?
    admin? || project_owner? || manager?
  end

  private
  def project_owner?
    project.owner?(user)
  end

  def membership
    @membership ||= project.membership_for(user)
  end

  def project_member?
    membership.present?
  end

  def manager?
    membership&.role == "manager"
  end

  def developer?
    membership&.role == "developer"
  end
end
