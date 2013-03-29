class Group < ActiveRecord::Base
  attr_accessible :creator_id, :name

  has_many :group_users
  has_many :users, :through => :group_users

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
end
