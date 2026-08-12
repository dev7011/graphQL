# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :owner, Types::UserType, null: false
    # return 0, 1, 2
    # field :status, Integer, null: true
    field :status, String, null: true
    field :display_name, String, null: false

    field :members, [Types::UserType], null: false do
      description "List of members associated with the project"
    end

    def display_name
      "#{object.name} (#{object.status})"
    end
  end
end
