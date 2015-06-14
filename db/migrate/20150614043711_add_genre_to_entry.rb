class AddGenreToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :genre, :integer
  end
end
