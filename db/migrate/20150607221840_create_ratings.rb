class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :entry_id
      t.boolean :seen

      t.timestamps
    end
  end
end
