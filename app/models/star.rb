class Star < ActiveRecord::Base
  attr_accessible :name, :requirement

  has_many :achievements
  has_many :users, :through => :achievements
  has_many :requirements

end