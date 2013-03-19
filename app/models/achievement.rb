class Achievement < ActiveRecord::Base
  attr_accessible :star_id, :user_id

  belongs_to :user
  belongs_to :star
  
end
