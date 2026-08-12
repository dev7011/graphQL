class ProjectPolicy
  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    admin? || owner?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  private

  attr_reader :user, :project

  def admin?
    user.admin?
  end

  def owner?
    user.user? && project.owner_id == user.id
  end
end