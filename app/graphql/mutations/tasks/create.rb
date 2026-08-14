module Mutations
  module Tasks
    class Create < Mutations::BaseMutation
      graphql_name "CreateTask"

      argument :project_id, ID, required: true
      argument :attributes, Types::Inputs::TaskInput, required: true

      field :task, Types::TaskType, null: true
      field :errors, [String], null: false

      def resolve(project_id:, attributes:)
        user = authenticate_user!

        project = find_project!(project_id)

        authorize!(project, :create?, user: user)

        attrs = attributes.to_h
        assignee_id = attrs.delete(:assignee_id)
        assignee = find_valid_assignee(project, assignee_id)
        task = project.tasks.new(attrs.merge(assignee: assignee))

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