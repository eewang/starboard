class User < ActiveRecord::Base
  attr_accessible :name, :profile_pic, :treehouse_username, :codeschool_username, :blog_url, :email

  has_many :achievements
  has_many :stars, :through => :achievements

  def get_profile_pic_from_email(email)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/" + hash
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
