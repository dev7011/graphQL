class ProjectPolicy < BasePolicy
  def initialize(user, project)
    super(user, project)
  end

  private

  def owner?
    project.owner_id == user.id
  end

  def member?
    project.project_members.exists?(
      user_id: user.id
    )
  end
end