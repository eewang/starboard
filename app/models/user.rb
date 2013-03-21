class User < ActiveRecord::Base
  before_save :get_user_data

  attr_accessible :name, :profile_pic, :treehouse_username, :codeschool_username, :blog_url, :email

  has_many :achievements
  has_many :stars, :through => :achievements

  def get_user_data
    codeschool = Codeschool.get_codeschool_data(self.codeschool_username)
    check_achievements_by_array(codeschool)
  end

  def check_achievement_by_string(string)
    star = Star.where(:name => string).first_or_create
    starids = self.stars.collect { |a| a.id }
    unless starids.include? star.id
      self.achievements.build(:star_id => star.id)
    end
  end

  def check_achievements_by_array(array)
    array.each { |item| check_achievement_by_string(item) }

  def get_profile_pic_from_email(email)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/" + hash + "?s=140"
  end

  def get_profile_pic
    self.profile_pic = get_profile_pic_from_email(self.email)
  end

end

# Avi Notes:

#   attr_accessor :codeschool_username

#   def codeschool
#     CodeSchool.new(self.codeschool_username)
#   end
# end

# avi = User.find_by_name("avi")
# avi.codeschool.completed_courses

# class CodeSchool
#   def completed_courses
#     open("")
