class GroupUser < ActiveRecord::Base
  attr_accessible :user_id, :group_id

  belongs_to :user
  belongs_to :group

  def self.find_group(params)
    Group.where(:name => params[:group_name], :password => params[:group_password]).first
  end

end
