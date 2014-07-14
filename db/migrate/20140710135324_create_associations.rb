class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.integer :backlog_id
      t.integer :entry_id

      t.timestamps
    end

    add_index :associations, :backlog_id
    add_index :associations, :entry_id
    add_index :associations, [:backlog_id, :entry_id], unique: true
  end
end
