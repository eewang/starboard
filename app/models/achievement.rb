require 'open-uri'

class Achievement < ActiveRecord::Base
  attr_accessible :star_id, :user_id

  belongs_to :user
  belongs_to :star

  def self.get_from_codeschool
    doc = open('http://www.codeschool.com/users/dolinsky.json').read
    cs_hash = JSON.parse(doc)

    name = cs_hash["user"]["username"]
  end


end
