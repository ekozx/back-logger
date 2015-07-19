class CreateGenres < ActiveRecord::Migration
  def change

    create_table :genres do |t|
      t.string :genre_name
      t.timestamps
    end

    create_table :genre_mappings do |t|
      t.integer :entry_id
      t.integer :genre_id
    end

    add_index :genre_mappings, :genre_id
    add_index :genre_mappings, :entry_id
    add_index :genre_mappings, [:genre_id, :entry_id], unique: true
  end
end
