class AchievementsController < ApplicationController
  # Used for Give Star Modal
  def new
    @achievement = Achievement.new
    if params[:group_id].present?
      @group = Group.find(params[:group_id])
      @users = @group.users
    end

    source_id = Source.where(:name => "Teacher").first.id
    @teacher_stars = Star.where(:source_id => source_id)
    render :layout => false
  end

  def create
    @achievement = Achievement.new(params[:achievement])

    if params[:star_name]
      star_id = Star.first_or_create(:name => params[:star_name]).id
    else
      star_id = Star.where(:name => "Gifted Star").first.id
    end

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
