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

  def distance_of_time_in_days_hours_and_minutes(from_time, to_time)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_days    = (((to_time - from_time).abs) / 86400).round
    distance_in_hours   = (((to_time - from_time).abs) / 3600).round
    distance_in_minutes = ((((to_time - from_time).abs) % 3600) / 60).round

    difference_in_words = ''

    if distance_in_days < 0
      difference_in_words << "#{distance_in_hours} #{distance_in_hours > 1 ? 'hrs' : 'hr' } and " if distance_in_hours > 0
      difference_in_words << "#{distance_in_minutes} #{distance_in_minutes == 1 ? 'min' : 'mins' }"
    else
      difference_in_words << "#{distance_in_days} #{distance_in_days > 1 ? 'days' : 'day' }"
    end
  end

  def as_json(option={})
    {
      :id               => self.id,
      :created          => distance_of_time_in_days_hours_and_minutes(self.created_at, Time.now),
      :star             => self.star.name,
      :sender           => self.sender_id,
      :message          => self.message,
      :user_id          => self.user.id,
      :user_name        => self.user.name
    }
  end


end