class RemovePasswordsColumnFromGroupTable < ActiveRecord::Migration
  def change
    remove_column :groups, :password
  end

end
