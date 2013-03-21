class Codeschool 
  include HTTParty
  
  def self.get_data(username)
    cs_json = self.get("http://codeschool.com/users/#{username}.json")
    self.get_completed_courses(cs_json)
  end

  def self.get_completed_courses(cs_json)
    cs_json["courses"]["completed"].collect { |course| course["title"] }
  end

end


