# frozen_string_literal: true

module Resolvers
  module Tasks
    class TasksResolver < BaseResolver
      type Types::Tasks::TaskType.connection_type, null: false

      argument :project_id,
        ID,
        required: true

      argument :filter,
        Types::Inputs::TaskFilterInput,
        required: false

      argument :sort_by,
        Types::Enums::TaskSortFieldEnum,
        required: false,
        default_value: "created_at"

      argument :sort_direction,
        Types::Enums::SortDirectionEnum,
        required: false,
        default_value: "DESC"

      def resolve(
        project_id:,
        filter: nil,
        sort_by:,
        sort_direction:
      )
        sort_direction =
          sort_direction.to_s.downcase

        authenticate_user!

        project =
          find_project!(
            project_id
          )

        authorize_read!(
          project
        )

        filters =
          filter ? filter.to_h : {}

        validate_filters!(
          filters
        )

        scope =
          apply_filters(
            project.tasks,
            filters
          )

        apply_sort(
          scope,
          sort_by,
          sort_direction
        )
      end

      private

      # ---------------------------
      # Validation
      # ----------------------

      def validate_filters!(filters)
        validate_assignee_filters!(
          filters
        )

        validate_due_date_range!(
          filters
        )
      end

      def validate_assignee_filters!(filters)
        return unless filters[:unassigned] == true
        return if filters[:assignee_id].blank?

        validation_error!(
          "assigneeId and unassigned cannot be used together"
        )
      end

      def validate_due_date_range!(filters)
        due_from =
          filters[:due_from]

        due_to =
          filters[:due_to]

        return unless due_from && due_to
        return if due_from <= due_to

        validation_error!(
          "dueFrom must be before or equal to dueTo"
        )
      end

      def validation_error!(message)
        raise Errors::GraphqlError.new(
          message,
          code: "VALIDATION_ERROR"
        )
      end

      # ---------------------------
      # Filters
      # ---------------------------

      def apply_filters(scope, filters)
        scope =
          filter_status(
            scope,
            filters[:status]
          )

        scope =
          filter_priority(
            scope,
            filters[:priority]
          )

        scope =
          filter_assignee(
            scope,
            filters
          )

        scope =
          filter_due_date(
            scope,
            filters
          )

        scope =
          filter_overdue(
            scope,
            filters
          )

        filter_search(
          scope,
          filters[:search]
        )
      end

      def filter_status(scope, statuses)
        return scope if statuses.blank?

        scope.where(
          status: statuses
        )
      end

      def filter_priority(scope, priorities)
        return scope if priorities.blank?

        scope.where(
          priority: priorities
        )
      end

      def filter_assignee(scope, filters)
        if filters[:unassigned] == true
          return scope.where(
            assignee_id: nil
          )
        end

        assignee_id =
          filters[:assignee_id]

        return scope if assignee_id.blank?

        scope.where(
          assignee_id: assignee_id
        )
      end

      def filter_due_date(scope, filters)
        due_from =
          filters[:due_from]

        due_to =
          filters[:due_to]

        if due_from
          scope =
            scope.where(
              "tasks.due_date >= ?",
              due_from
            )
        end

        if due_to
          scope =
            scope.where(
              "tasks.due_date <= ?",
              due_to
            )
        end

        scope
      end

      def filter_overdue(scope, filters)
        return scope unless filters[:overdue] == true

        scope
          .where(
            "tasks.due_date < ?",
            Date.current
          )
          .where.not(
          status: "done"
        )
      end

      def filter_search(scope, search)
        search =
          search.to_s.strip

        return scope if search.blank?

        escaped =
          Task.sanitize_sql_like(
            search
          )

        term =
          "%#{escaped}%"

        tasks =
          Task.arel_table

        scope.where(
          tasks[:title]
            .matches(term)
            .or(
              tasks[:description]
                .matches(term)
            )
        )
      end

      # ---------------------------
      # Sorting
      # ---------------------------

      def apply_sort(scope, sort_by, direction)
        case sort_by
        when "priority"
          sort_by_priority(
            scope,
            direction
          )

        when "due_date"
          sort_by_due_date(
            scope,
            direction
          )

        else
          scope.order(
            sort_by => direction,
            id: direction
          )
        end
      end

      def sort_by_priority(scope, direction)
        rank =
          if direction == "asc"
            <<~SQL.squish
              CASE tasks.priority
                WHEN 'low' THEN 1
                WHEN 'medium' THEN 2
                WHEN 'high' THEN 3
                ELSE 4
              END ASC
            SQL
          else
            <<~SQL.squish
              CASE tasks.priority
                WHEN 'high' THEN 1
                WHEN 'medium' THEN 2
                WHEN 'low' THEN 3
                ELSE 4
              END ASC
            SQL
          end

        scope.order(
          Arel.sql(rank),
          id: direction
        )
      end

      def sort_by_due_date(scope, direction)
        due_date_order =
          if direction == "asc"
            Task.arel_table[:due_date].asc.nulls_last
          else
            Task.arel_table[:due_date].desc.nulls_last
          end

        scope.order(
          due_date_order,
          id: direction
        )
      end
    end
  end
end