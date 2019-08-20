class AddColRoleUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :level
    remove_column :users, :admin
    add_column :users, :role, :integer, default: 0
  end
end
