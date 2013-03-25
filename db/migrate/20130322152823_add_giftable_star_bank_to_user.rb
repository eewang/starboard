class AddGiftableStarBankToUser < ActiveRecord::Migration
  def change
    add_column :users, :giftable_star_bank, :integer
  end
end
