module Types
  module Enums
    class ProjectMemberRoleEnum < Types::BaseEnum
      value "MANAGER",
            value: "manager"

      value "DEVELOPER",
            value: "developer"

      value "VIEWER",
            value: "viewer"
    end
  end
end