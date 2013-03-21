class Achievement < ActiveRecord::Base
  attr_accessible :star_id, :user_id, :sender, :receiver, :message, :star

  belongs_to :user
  belongs_to :star

  def self.create_from_user(sender_id, receiver_id, message)
    @sender = User.find(sender_id)
    @receiver = User.find(receiver_id)
    star = Star.where(:name => "teacher star").first_or_create
    @star_id = star.id
  end

end