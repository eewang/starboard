class DropStackoverflowUsernameFromUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :stackoverflow_username
  end
  
end
