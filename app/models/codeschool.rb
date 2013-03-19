require 'open-uri'

class CodeSchool < ActiveRecord::Base
  attr_accessor :cs_json

  def initialize(url) # url = 'http://www.codeschool.com/users/dolinsky.json'
    get_json(url)
  end

  def get_json(url)
    doc = open(url).read
    @cs_json = JSON.parse(doc)
  end

  def get_data_from_codeschool
    username = @cs_json["user"]["username"]
    completed_coures = @cs_json["courses"]["completed"].collect do |c|
      c["title"]
    end
  end

end