class Achievement < ActiveRecord::Base
  attr_accessible :star_id, :user_id, :sender_id, :sender, :message, :star

  belongs_to :user
  belongs_to :star

  # def self.create_from_user(sender_id, receiver_id, message)
  #   sender = User.find(sender_id)
  #   receiver = User.find(receiver_id)
  #   star = Star.where(:name => "teacher star").first_or_create
  #   star_id = star.id
  # end
  def self.get_recent_achievements(id)
    if id == 0
      Achievement.find(:all, :order => "id desc", :limit => 20).reverse
    else
      Achievement.find(:all, :order => "id desc", :limit => 20, :conditions => ["id > ?", id])
    end
  end

  def as_json(option={})
    {
      :id               => self.id,
      :star             => self.star.name,
      :sender           => self.sender_id,
      :message          => self.message,
      :user_id          => self.user.id,
      :user_name        => self.user.name
    }
  end
end