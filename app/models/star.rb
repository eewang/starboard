class Star < ActiveRecord::Base
  attr_accessible :name, :requirement

  has_many :achievements
  has_many :users, :through => :achievements
  has_many :requirements
  belongs_to :source

  validates_uniqueness_of :name

  #@TODO - Star's responsibility to give a star, not the user

    def as_json(option={})
    {
      :name   => self.name,
      :source => self.source
    }
  end

end