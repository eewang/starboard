class HandraiseController < ApplicationController

  def create
    if params[:token] == "3575dbf50eb70f3cdd15"
      source_id = Source.where(:name => "Handraise").first.id
      star = Star.where(:source_id => source_id).find_or_create_by_name("Handraise")
      user = User.where(:email => params[:goldstar_email]).first

      user.achievements.create(:star_id => star.id)   
    end
  end
end
