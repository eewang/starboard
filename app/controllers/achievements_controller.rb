class AchievementsController < ApplicationController

  def create

    @achievement = Achievement.new(params[:achievement])
    star_id = Star.where(:name => "Gifted Star").first.id
    @achievement.sender_id = current_user.id
    @achievement.star_id = star_id
    user_id = User.where(:name => params[:user_name]).first.id
    @achievement.user_id = user_id

    redirect_to 'groups#show'
  end

end
