class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Horse.new(params[:horse])

    if @invitation.save
      format.html redirect_to @invitation, notice: 'Horse was successfully created.'
    else
      format.html { render action: "new" }
    end
  end

end
