class CreateBacklogs < ActiveRecord::Migration
  def change
    create_table :backlogs do |t|
      t.integer :user_id
      t.integer :entry_id
      t.belongs_to :user

      t.timestamps
    end
    add_reference :backlogs, :entries, index: true 
  end
end
