class RenameBlogsToBlogPosts < ActiveRecord::Migration
  def up
    rename_table :blogs, :blogposts
  end

  def down
    rename_table :blogposts, :blogs
  end
end
