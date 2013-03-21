class User < ActiveRecord::Base
  attr_accessible :name, :profile_pic, :treehouse_username, :codeschool_username, :blog_url

  has_many :achievements
  has_many :stars, :through => :achievements


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