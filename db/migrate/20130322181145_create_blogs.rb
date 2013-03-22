class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.datetime :last_checked
      t.integer :user_id
      t.timestamps
    end
  end
end
