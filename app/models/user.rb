class User < ActiveRecord::Base
  before_save :get_external_data

  attr_accessible :name, :profile_pic, :treehouse_username, :codeschool_username, :github_username, :blog_url, :email

  has_many :achievements
  has_many :stars, :through => :achievements

  def add_code_school_job
    
  end

  def get_external_data
    external_services = 
    { 
      Treehouse => self.treehouse_username,
      Codeschool => self.codeschool_username,
      Github => self.github_username
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

end
