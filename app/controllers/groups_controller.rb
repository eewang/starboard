class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index

    if current_user
      @groups = Group.all
      if @groups.count == 1
        redirect_to "/groups/#{@groups.first.id}"
      else
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @groups }
        end
      end
    else
      redirect_to '/users/new'
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if current_user
      @group = Group.find(params[:id])
      # @users_test = User.where( GroupUser.where(:group_id => params[:id])
      @users = User.joins(:groups).where("group_id = #{params[:id]}")

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @group }
      end
    else
      redirect_to root_path
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    if current_user
      @group = Group.new
      @invitation = @group.invitations.build

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @group }
      end
    else
      redirect_to root_path
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    if current_user
      #injecting the creator_id in since it isn't passed through in params
      params[:group][:creator_id] = current_user.id
      @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        if params[:emails]
          EmailsWorker.perform_asynch(@group.id, params)
        end
      end
    else
      redirect_to root_path
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  # API Stuff
  def get_recent_achievements
    if current_user
      @group = Group.where(params[:groupid]).first
      @achievements = @group.get_recent_achievements(params[:latest])
      respond_to do |format|
        format.json { render json: @achievements }
      end
    else
      redirect_to root_path
    end
  end
end
