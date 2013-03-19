require 'pry'

class Codeschool 
  include HTTParty

  attr_accessor :username

  def initialize(username)
    @username = username
  end

  def profile_user
    cs_json = Codeschool.get("http://codeschool.com/users/#{@username}.json")
    get_data_from_codeschool(cs_json)
  end

  def get_data_from_codeschool(cs_json)
    completed_courses = cs_json["courses"]["completed"].collect do |c|
      c["title"]
    end
    # raise completed_courses.inspect
    create_achievement(completed_courses)
  end

  def create_achievement(completed_courses)
    user = User.create(:name => "Bob")
    completed_courses.each do |c|
      star = Star.find_or_create_by_name(c)
      user.achievements.create(:star_id => star.id)
    end
  end
end


