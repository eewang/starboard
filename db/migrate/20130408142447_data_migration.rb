class DataMigration < ActiveRecord::Migration
  def change
    remove_column :stars, :type
    drop_table :requirements
    add_column :users, :tagline, :string
  end
end
