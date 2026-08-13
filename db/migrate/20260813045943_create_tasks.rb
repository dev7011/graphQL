class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :status
      t.string :priority
      t.date :due_date
      t.references :assignee, null: false,
        foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
