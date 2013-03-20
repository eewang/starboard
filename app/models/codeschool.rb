require 'pry'

class Codeschool 
  include HTTParty
  
  attr_accessor :username

  def initialize(username)
    @username = username
  end

  #gets profile data back from codeschool
  def profile_user
    cs_json = Codeschool.get("http://codeschool.com/users/#{@username}.json")
    get_data_from_codeschool(cs_json)
  end

  #create completed courses array
  def get_data_from_codeschool(cs_json)
    completed_courses = cs_json["courses"]["completed"].collect do |c|
      c["title"]
    end
    create_achievement(completed_courses)
  end

  def create_achievement(completed_courses)
    user = User.create(:name => "Bob") #hard coded for now, will need to change based on current user
    completed_courses.each do |c|
      star = Star.find_or_create_by_name(c) #create stars for each completed course
      user.achievements.create(:star_id => star.id)
    end
  end
end


