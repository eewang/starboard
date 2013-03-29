class Invitation < ActiveRecord::Base
  attr_accessible :email, :sender_id, :token, :group_id

  belongs_to :group
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

end
