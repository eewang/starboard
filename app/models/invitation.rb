class Invitation < ActiveRecord::Base
  attr_accessible :email, :sender_id, :token, :group_id

  belongs_to :group
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def self.find_group_by_token(token)
    self.where(:token => token).first.group
  end

end
