class AddThbadgesToUser < ActiveRecord::Migration
  def change
    add_column :users, :thbadges, :text
  end
end
