
  module Projects
    class RemoveMember
    def initialize(project:, user:)
      @project = project
      @user = user
    end

    def call
      validate!

      project_member = project
                         .project_members
                         .find_by(user_id: user.id)

      unless project_member
        return {
          success: false,
          removed_user_id: nil,
          errors: ["Project member not found"]
        }
      end

      removed_user_id = project_member.user_id

      if project_member.destroy
        {
          success: true,
          removed_user_id: removed_user_id,
          errors: []
        }
      else
        {
          success: false,
          removed_user_id: nil,
          errors: project_member.errors.full_messages
        }
      end
    end

    private

    attr_reader :project, :user

    def validate!
      if project.owner?(user)
        return {
          success: false,
          removed_user_id: nil,
          errors: ["Project owner cannot be removed"]
        }
      end
    end
    end
  end
