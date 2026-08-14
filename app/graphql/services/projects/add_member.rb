
  module Projects
    class AddMember
      def initialize(project:, user:)
        @project = project
        @user = user
      end

      def call
        validate!

        project.project_members
               .create(user: user)
      end

      private

      attr_reader :project, :user

      def validate!
        if project.owner?(user)
          raise ArgumentError,
                "Project owner cannot be added as a member"
        end

        if project.project_members.exists?(user_id: user.id)
          raise ArgumentError,
                "User is already a project member"
        end
      end
    end
  end
