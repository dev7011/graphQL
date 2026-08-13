class TaskPolicy
  def initialize(user, task_or_project)
    @user = user

    if task_or_project.is_a?(Task)
      @task = task_or_project
      @project = task_or_project.project
    else
      @project = task_or_project
    end
  end

  def create?
    admin? || owner? || editable_member?
  end

  def update?
    admin? || owner? || editable_member?
  end

  def destroy?
    admin? || owner?
  end

  def assign?
    admin? || owner? || editable_member?
  end

  private

  attr_reader :user, :task, :project

  def admin?
    user.admin?
  end

  def owner?
    project.owner_id == user.id
  end

  def editable_member?
    return false unless user.user?

    project.project_members.exists?(
      user_id: user.id
    )
  end
end