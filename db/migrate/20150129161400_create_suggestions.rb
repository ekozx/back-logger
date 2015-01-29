class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :git
      t.string :status

      t.timestamps
    end
  end
end
