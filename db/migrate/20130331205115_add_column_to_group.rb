class AddColumnToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :password, :string
  end
end
