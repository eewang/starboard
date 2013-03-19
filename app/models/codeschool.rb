require 'pry'

class Codeschool 
  include HTTParty
  base_uri 'codeschool.com/users/'


  def initialize(username)
    @username = username
  end

  def profile_user
    Codeschool.get("#{@username}.json")
  end

  def get_json
    doc = open(profile_user).read
    cs_json = JSON.parse(doc)
    get_data_from_codeschool(cs_json)
  end

  def get_data_from_codeschool(cs_json)
    completed_coures = cs_json["courses"]["completed"].collect do |c|
      c["title"]
    end
    # raise completed_courses.inspect
    create_achievement(completed_courses)
  end

  def create_achievement(completed_courses)
    user = User.create(:name => "Danny")
      star = Start.find_by_name(c)
      user.achievements.create(:star_id => star.id)
    end
  end

end