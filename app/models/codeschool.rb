require 'open-uri'

class CodeSchool < ActiveRecord::Base

  def get_json
    doc = open('http://www.codeschool.com/users/dolinsky.json').read
    JSON.parse(doc)
  end

  def self.get_data_from_codeschool
    username = cs_hash["user"]["username"]
    completed_coures = cs_hash["courses"]["completed"].collect do |c|
      c["title"]
    end
  end

end