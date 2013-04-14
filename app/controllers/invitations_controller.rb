class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
    @teacher_groups = current_user.groups.where(:creator_id => current_user.id)
  end

  def create
    @invitation = Invitation.new

    if @invitation.save
        if params[:emails]
          EmailsWorker.perform_async(params[:id], params[:emails])
        end
        flash[:success] = "emails are on their way out!"
        redirect_to current_user
    else
        flash[:alert] = "Sorry, group didn't save..."
        redirect_to new_group_path
    end
  end

end
