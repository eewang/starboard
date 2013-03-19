class CreateGithubstars < ActiveRecord::Migration
  def change
    add_column :stars, :type, :string
  end
end
