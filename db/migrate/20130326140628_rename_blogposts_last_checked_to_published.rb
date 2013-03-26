class RenameBlogpostsLastCheckedToPublished < ActiveRecord::Migration
  def up
    rename_column :blogposts, :last_checked, :published
  end

  def down
    rename_column :blogposts, :published, :last_checked
  end
end
