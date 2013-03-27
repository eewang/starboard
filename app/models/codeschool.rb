class Codeschool 
  include HTTParty
  
  def self.get_data(username)
    cs_json = self.get("http://codeschool.com/users/#{username}.json")
    case cs_json.code
      when 200
        self.get_completed_courses(cs_json)
      when 404
        p "Codeschool username not found - #{username}"
        return nil
      when 500..600
        p "ERROR Pulling from Codeschool #{response.code}"
        return nil
    end
  end

  def self.get_completed_courses(cs_json)
    if cs_json['courses']['completed']
      cs_json['courses']['completed'].collect { |course| course["title"] }
    end
  end

end