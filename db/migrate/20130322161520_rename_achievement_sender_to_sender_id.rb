class RenameAchievementSenderToSenderId < ActiveRecord::Migration
  def up
    rename_column :achievements, :sender, :sender_id
  end

  def down
    rename_column :achievements, :sender_id, :sender
  end
end
