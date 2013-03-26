class AddColumnToStar < ActiveRecord::Migration
  def change
    add_column :stars, :source_id, :integer
  end
end
