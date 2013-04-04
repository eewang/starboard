class AchievementsController < ApplicationController

  def create
    @achievement = Achievement.new(params[:achievement])
    star_id = Star.where(:name => "Gifted Star").first.id
    sender_id = current_user.id
    achievement.create()
  end

end
