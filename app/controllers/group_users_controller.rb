class GroupUsersController < ApplicationController

  def new
    @group_user = GroupUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star }
    end
  end

  def create
    @group_user = GroupUser.new
    # check name and password in db
    # if there, create association between user and group
    # if not, redirect back to join page with error message
    if GroupUser.find_group(params)
      @group_user.user_id = current_user.id
      @group_user.group_id = GroupUser.find_group(params).id

      respond_to do |format|
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
