class AddBlogCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :blog_count, :integer
  end
end
