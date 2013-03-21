require 'pry'

class Codeschool 
  include HTTParty
  
  attr_accessor :username

  #gets profile data back from codeschool
  def self.get_codeschool_data(username)
    cs_json = self.get("http://codeschool.com/users/#{username}.json")
    self.get_completed_courses(cs_json)
  end

  #create completed courses array
  def self.get_completed_courses(cs_json)
    completed_courses = cs_json["courses"]["completed"].collect do |c|
      c["title"]
    end
  end
end


