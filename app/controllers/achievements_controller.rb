class AchievementsController < ApplicationController
  def get_recent_achievements
    @achievements = Achievement.get_recent_achievements(params[:id])

    respond_to do |format|
      format.json { render json: @achievements }
    end
  end
end
