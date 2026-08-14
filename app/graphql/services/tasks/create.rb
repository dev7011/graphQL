module Tasks
  class Create

    def initialize(project, attributes)
      @project = project
      @attributes = attributes
    end

    def call
      attrs = attributes.to_h

      assignee_id = attrs.delete(:assignee_id)
      assignee = find_valid_assignee(project, assignee_id)

      task = project
               .tasks
               .new(attrs.merge(assignee: assignee))
      task.save

      task
    end

    private

    attr_reader :project, :attributes

    def find_valid_assignee(project, assignee_id)
      return nil if assignee_id.blank?

      assignee = User.find_by(id: assignee_id)

      raise ArgumentError,
            "Assignee not found" unless assignee

      unless project.includes_user?(assignee)
        raise ArgumentError,
              "Assignee must belong to the project"
      end

      assignee
    end
  end
end
