class AddRoleToProjectMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :project_members, :role, :string, null: false, default: "viewer"

    add_index :project_members, [:project_id, :role]
  end
end