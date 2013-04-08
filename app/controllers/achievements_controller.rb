class AchievementsController < ApplicationController
  # Used for Give Star Modal
  def new
    @achievement = Achievement.new
    if params[:group_id].present?
      @group = Group.find(params[:group_id])
      @users = @group.users
    end 
    render :layout => false
  end

  def create
    @achievement = Achievement.new(params[:achievement])
    star_id = Star.where(:name => "Gifted Star").first.id
    @achievement.sender_id = current_user.id
    @achievement.star_id = star_id
    @achievement.user_id = User.where(:name => params[:user_name]).first.id

    @achievement.save
      
    respond_to do |f|
      f.js {}
      f.html {}
    end
  end

end
