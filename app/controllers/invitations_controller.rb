# class InvitationsController < ApplicationController

#   def new
#     @invitation = Invitation.new
#   end

#   def create
#     @invitation = Invitation.new(params[:horse])

#     if @invitation.save
#       format.html redirect_to @invitation, notice: 'Horse was successfully created.'
#     else
#       format.html { render action: "new" }
#     end
#   end

# end


class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new

    if @invitation.save
      InvitationMailer.deliver_invitation(@invitation)
      format.html redirect_to @invitation, notice: 'Your group invitations have been sent'
    else
      format.html { render action: "new" }
    end
  end

end
