class AddRottenTomatoesIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :rotten_tomatoes_id, :integer
  end
end
