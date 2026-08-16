module Resolvers
  class DashboardResolver < BaseResolver
    type Types::DashboardType,
         null: false

    def resolve
      user = authenticate_user!

      projects =
        ProjectPolicy::Scope
          .new(user, Project)
          .resolve

      tasks =
        user.assigned_tasks

      {
        total_projects: projects.count,

        total_assigned_tasks: tasks,

        todo_count:
          tasks.where(
            status: "todo"
          ).count,

        in_progress_count:
          tasks.where(
            status: "in_progress"
          ).count,

        done_count:
          tasks.where(
            status: "done"
          ).count,

        overdue_count:
          tasks
            .where.not(status: "done")
            .where(
              "due_date < ?",
              Date.current
            )
            .count
      }
    end
  end
end