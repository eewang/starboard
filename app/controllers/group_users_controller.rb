class GroupUsersController < ApplicationController

  def new
    @group_user = GroupUser.new
    # so the modal doesn't error out we build an achievement
    @achievement = Achievement.new
    @group = Invitation.find_group_by_token(params[:invitation_token])
    @creator = User.find(@group.creator_id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star }
    end
  end

  def login
    if current_user
      redirect_to group_signup_url(:invitation_token => params[:invitation_token])
    else
      render new_session_path
    end
  end

  def create
    @group_user = GroupUser.new

    unless params[:invitation_token].empty?
      group_id = Invitation.find_group_by_token(params[:invitation_token]).id
      @group_user.group_id = group_id
      @group_user.user_id = current_user.id 
    end

    if respond_to do |format|
        @group_user.save
          format.html { redirect_to root_path, notice: 'Succesfully joined group.' }
          format.json { render json: @group_user.group_id, status: :created, location: @group_user.group_id }
      end
    else
        format.html { redirect_to 'http://localhost:3000/group/join' }
        format.json { render json: @group_user.errors, status: :unprocessable_entity }
    end
  end

end
