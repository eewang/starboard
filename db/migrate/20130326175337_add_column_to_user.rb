class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :stackoverflow_username, :string
  end
end
