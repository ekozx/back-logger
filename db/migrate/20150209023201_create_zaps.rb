class CreateZaps < ActiveRecord::Migration
  def change
    create_table :zaps do |t|
      t.boolean :seen
      t.string :message
      t.string :title
      t.integer :receiver_id
      t.integer :creator_id
      t.belongs_to :entry, index: true

      t.timestamps
    end
  end
end
