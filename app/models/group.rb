class Group < ActiveRecord::Base
  validates :name, :password, :presence => true

  attr_accessible :creator_id, :name, :password

  has_many :group_users
  has_many :users, :through => :group_users
  has_many :invitations

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  def get_recent_achievements(groupId=self.id, latestid=0)
    group_achievements = []
    self.users.each do |user|
      if latestid == 0
        group_achievements << Achievement.find(:all, :order => "id desc", :limit => 10, :conditions => ["user_id == ?", user.id])
      else
        group_achievements << Achievement.find(:all, :order => "id desc", :limit => 10, :conditions => ["id > ? AND user_id == ?", latestid, user.id])
      end
    end
    group_achievements[0]
  end

  def as_json(options={})
    {
      :name => self.name,
      :creator => User.find(self.creator_id),
      :students => self.users
    }
  end
end