class Requirement < ActiveRecord::Base
  attr_accessible :description, :star_id
  belongs_to :star
end
