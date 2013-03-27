class Treehouse
  include HTTParty

  def self.get_data(username)
    th_json = self.get("http://www.teamtreehouse.com/#{username}.json")
    case th_json.code
      when 200
        self.get_names_from_treehouse(th_json)
      when 404
        p "Treehouse username not found - #{username}"
        return nil
      when 500..600
        p "ERROR Pulling from Treehouse #{response.code}"
        return nil
    end
  end

  def self.get_names_from_treehouse(th_json)
    th_json["badges"].collect { |badge| badge["name"] }
  end

end