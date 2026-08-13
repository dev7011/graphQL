module Mutations
  module Tasks
    class Create < Mutations::BaseMutation
      graphql_name "CreateTask"

      argument :project_id, ID, required: true
      argument :title, String, required: true
      argument :description, String, required: false
      argument :priority, Types::Enums::TaskPriorityEnum, required: false
      argument :status, Types::Enums::TaskStatusEnum, required: false
      argument :due_date, GraphQL::Types::ISO8601Date, required: false
      argument :assignee_id, ID, required: false

      field :task, Types::TaskType, null: true
      field :errors, [String], null: false

      def resolve(
        project_id:,
        title:,
        description: nil,
        priority: "medium",
        due_date: nil,
        assignee_id: nil
      )
        user = authenticate_user!

        project = find_project!(project_id)

        authorize!(project, :create?, user: user)

        assignee =
          find_valid_assignee(
            project,
            assignee_id
          )

        task = project.tasks.new(
          title: title,
          description: description,
          priority: priority,
          due_date: due_date,
          assignee: assignee
        )

        if task.save
          {
            task: task,
            errors: []
          }
        else
          {
            task: nil,
            errors: task.errors.full_messages
          }
        end
      rescue GraphQL::ExecutionError
        raise
      rescue ArgumentError => e
        {
          task: nil,
          errors: [e.message]
        }
      end

      private

      def find_valid_assignee(project, assignee_id)
        return nil if assignee_id.blank?

        assignee = User.find_by(id: assignee_id)

        raise ArgumentError,
              "Assignee not found" unless assignee

        unless project_user?(
          project,
          assignee
        )
          raise ArgumentError,
                "Assignee must belong to the project"
        end

        assignee
      end

      def project_user?(project, user)
        return true if project.owner_id == user.id

        project.project_members.exists?(
          user_id: user.id
        )
      end
    end
  end
end