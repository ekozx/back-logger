class AddImdbIdToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :imdb_id, :string
  end
end
