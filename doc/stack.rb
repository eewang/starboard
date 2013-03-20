require 'httparty'

class Stackexchange
  include HTTParty
  attr_accessor :doc, :url

  def url
    @url = "https://api.stackexchange.com/2.1/users/309545/badges?order=desc&sort=rank&site=stackoverflow"
  end
  # => need to refactor out query params using api credentials and oauth stuff.

  def get_doc
    @doc = self.class.get(@url)
  end

  def get_badge_names
    @doc["items"].collect do |badge|
      badge["name"]
    end
  end
  # => returns an array ["Teacher", "Student", "Editor", "Supporter", etc...]

end