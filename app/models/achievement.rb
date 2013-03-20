require 'open-uri'

class Achievement < ActiveRecord::Base
  attr_accessible :star_id, :user_id, :sender, :receiver, :message, :star

  belongs_to :user
  belongs_to :star


  def self.get_from_codeschool
    doc = open('http://www.codeschool.com/users/dolinsky.json').read
    cs_hash = JSON.parse(doc)
    completed_coures = cs_hash["courses"]["completed"].each do |c|
      puts c["title"]
    end
  end


  def self.create_from_user(sender_id, receiver_id, message)
    @sender = User.find(sender_id)
    @receiver = User.find(receiver_id)
    star = Star.where(:name => "teacher star").first_or_create
    @star_id = star.id
  end

end

def create_star_from_user
  Achievement.create_from_user(params[:sender], params[:receiver], params[:message])
end
