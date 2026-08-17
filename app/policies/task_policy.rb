# frozen_string_literal: true

class TaskPolicy
  def initialize(user, record)
    @user = user

    if record.is_a?(Task)
      @task = record
      @project = record.project
    else
      @project = record
    end
  end

  # Admin, Project Owner hoặc bất kỳ ProjectMember nào
  # đều được xem Task.
  def show?
    admin? ||
      project_owner? ||
      project_member?
  end

  # Admin, Owner, Manager, Developer được tạo Task.
  def create?
    admin? ||
      project_owner? ||
      manager? ||
      developer?
  end

  # Admin, Owner, Manager, Developer được update Task.
  def update?
    admin? ||
      project_owner? ||
      manager? ||
      developer?
  end

  # Admin, Owner, Manager, Developer được assign Task.
  def assign?
    admin? ||
      project_owner? ||
      manager? ||
      developer?
  end

  # Admin, Owner, Manager được delete Task.
  # Developer không được delete.
  def destroy?
    admin? ||
      project_owner? ||
      manager?
  end

  private

  attr_reader :user, :task, :project

  def admin?
    user.admin?
  end

  def project_owner?
    project.owner?(user)
  end

  def membership
    @membership ||=
      project.membership_for(user)
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