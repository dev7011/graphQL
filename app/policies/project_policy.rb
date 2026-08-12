class ProjectPolicy
  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    admin? || owner? || member?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  def manage_members?
    admin? || owner?
  end

  private

  attr_reader :user, :project

  def admin?
    user.admin?
  end

  def owner?
    project.owner_id == user.id
  end

  def member?
    project.project_members.exists?(
      user_id: user.id
    )
  end
end