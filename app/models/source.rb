class Source < ActiveRecord::Base
  attr_accessible :name

  has_many :stars

  def self.teacher
    Source.where(:name => "Teacher").first
  end
end
