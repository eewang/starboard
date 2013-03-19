require 'open-uri'

class CodeSchool < Achievement

  # def initialize(url) # url = 'http://www.codeschool.com/users/dolinsky.json'
  #   get_json(url)
  # end

  def get_json('http://www.codeschool.com/users/dolinsky.json')
    doc = open(url).read
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
    completed_courses.each do |c|
      user.achievements.create(:name => c)
    end
  end

end