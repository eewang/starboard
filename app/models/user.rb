class User < ActiveRecord::Base
  # before_save :get_external_data

  attr_accessible :name, :profile_pic, :treehouse_username, :codeschool_username, :github_username, :blog_url, :email, :password, :password_confirmation

  #@TODO - Build out validation rules
  validates_uniqueness_of :email

  has_secure_password

  has_many :achievements
  has_many :stars, :through => :achievements
  has_many :blogs

  def add_code_school_job
    
  end

  def get_external_data
    external_services = 
    { 
      Treehouse => self.treehouse_username,
      Codeschool => self.codeschool_username,
      Github => self.github_username
      # Blog => self.blog_url
    }
    external_services.each do |service, username|
      array = service.get_data(username)
      check_achievements_by_array(array)
    end
  end

  def check_achievement_by_string(string)
    star = Star.where(:name => string).first_or_create
    # @TODO - has many collection ... star_ids
    starids = self.stars.collect { |a| a.id }
    unless starids.include? star.id
      self.achievements.build(:star_id => star.id)
    end
  end

  def check_achievements_by_array(array)
    array.each { |item| check_achievement_by_string(item) }
  end

  def get_profile_pic_from_email(email)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/" + hash + "?s=140"
  end

  def get_profile_pic
    self.profile_pic = get_profile_pic_from_email(self.email)
  end

  def refresh_bank
    @giftable_star_bank = 1000
  end

  def can_give_star?
    self.giftable_star_bank > 0
  end

  def give_achievement_to(receiver, message)
    # self.giftable_star_bank -= # REPLACE WITH ACTIVE RECORD COUNTERS
    star = Star.where(:name => "Gifted Star").first
    receiver.achievements.create({ :star_id => star.id, 
                                   :message => message,
                                   :sender_id => self.id })
  end


  def get_star_id
    star_ids = self.achievements.collect do |achievement|
      achievement.star_id
    end
    star_ids.uniq.compact
  end

  def get_star_name
    stars = Star.all.collect do |star|
      if self.get_star_id.include?(star.id)
        star.name
      else
        nil
      end
    end
     stars.compact
  end

end
