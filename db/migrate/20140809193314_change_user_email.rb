
class ChangeUserEmail < ActiveRecord::Migration
  def change
    remove_index :users, :email
    remove_column :users, :email, :string
    add_column :users, :email, :string
    add_index :users, :email
  end
end
