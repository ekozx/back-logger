class CreateZaps < ActiveRecord::Migration
  def change
    create_table :zaps do |t|
      t.string :message
      t.references :entry, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
