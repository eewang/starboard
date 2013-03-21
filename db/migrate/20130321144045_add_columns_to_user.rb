class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :treehouse_username, :string
    add_column :users, :codeschool_username, :string
    add_column :users, :blog_url, :string
  end
end
