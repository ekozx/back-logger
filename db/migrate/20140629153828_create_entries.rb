class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.belongs_to :backlogs
      t.references :backlog, index: true

      t.timestamps
    end
  end
end
