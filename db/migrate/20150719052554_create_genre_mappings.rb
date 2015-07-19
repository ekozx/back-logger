class CreateGenreMappings < ActiveRecord::Migration
  def change
    create_table :genre_mappings do |t|
      t.integer :entry_id
      t.integer :genre_id
      t.timestamps
    end

    add_index :genre_mappings, :genre_id
    add_index :genre_mappings, :entry_id
    add_index :genre_mappings, [:genre_id, :entry_id], unique: true
  end
end
