module ModelHelpers
  extend ActiveSupport::Concern

  private

  def find_model!(model, id)
    model.find_by(id: id) ||
      raise(
        GraphQL::ExecutionError,
        "#{model.name} not found"
      )
  end

  def find_project!(id)
    Project.find_by(id: id) ||
      raise(
        GraphQL::ExecutionError,
        "Project not found"
      )
  end
end