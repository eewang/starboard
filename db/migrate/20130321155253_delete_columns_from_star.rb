class DeleteColumnsFromStar < ActiveRecord::Migration
  def change
    remove_column :stars, :requirement
  end
end
