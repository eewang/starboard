require 'open-uri'

class Achievement < ActiveRecord::Base
  attr_accessible :star_id, :user_id

  belongs_to :user
  belongs_to :star

  def self.get_from_codeschool
    doc = open('http://www.codeschool.com/users/dolinsky.json').read
    cs_hash = JSON.parse(doc)
    completed_coures = cs_hash["courses"]["completed"].each do |c|
      puts c["title"]
    end
  end

end
