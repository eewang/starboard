class User < ActiveRecord::Base
  before_save :get_user_data

  attr_accessible :name, :profile_pic, :treehouse_username, :codeschool_username, :blog_url

  has_many :achievements
  has_many :stars, :through => :achievements


  def get_user_data
    codeschool = Codeschool.get_codeschool_data(self.codeschool_username)
    check_achievements_by_array(codeschool)
  end

  def check_achievement_by_string(string)
    star = Star.where(:name => string).first_or_create
    self.achievements.build(:star_id => star.id)
  end

  def check_achievements_by_array(array)
    array.each { |item| check_achievement_by_string(item) }
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
