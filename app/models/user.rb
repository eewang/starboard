class User < ActiveRecord::Base
  attr_accessible :name

  has_many :achievements
  has_many :stars, :through => :achievements
  
end
