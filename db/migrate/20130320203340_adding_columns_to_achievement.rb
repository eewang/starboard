class AddingColumnsToAchievement < ActiveRecord::Migration
  def change
    add_column :achievements, :sender, :integer
    add_column :achievements, :receiver, :integer
    add_column :achievements, :message, :string
  end
end
