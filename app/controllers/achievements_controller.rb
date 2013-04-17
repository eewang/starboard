class AchievementsController < ApplicationController
  # Used for Give Star Modal
  def new
    @achievement = Achievement.new
    if params[:group_id].present?
      @group = Group.find(params[:group_id])
      @users = @group.users
    end

    source_id = Source.teacher.id
    @teacher_stars = Star.where(:source_id => source_id)
    render :layout => false
  end

  def create
    @achievement = Achievement.new(params[:achievement])

    if params[:star_name]
      star_id = Source.teacher.stars.where(:name => params[:star_name]).first_or_create.id
      @achievement.star_id = star_id
    else
      star_id = Star.where(:name => "Gifted Star").first.id
      @achievement.star_id = star_id
    end

    @achievement.sender_id = current_user.id
    @achievement.user_id = User.where(:name => params[:user_name]).first.id

    if @achievement.save
      current_user.remove_star_from_starbank
      current_user.save
      
      respond_to do |f|
        f.js {}
        f.html {}
      end
    end
  end

end
