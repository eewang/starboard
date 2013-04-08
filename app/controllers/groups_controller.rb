class GroupsController < ApplicationController
  before_filter :instantiate_achievement

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
      redirect_to '/login'
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    redirect_to "/groups/#{params[:id]}/leaderboard"
  end

  def self.group_views(*views)
    views.each do |view|
      define_method "#{view}" do
        if current_user
          @active_nav = view.to_s
          @group = Group.find(params[:id])
          @users = User.joins(:groups).where("group_id = #{params[:id]}").sort_by { |user| user.achievements.count }.reverse

          respond_to do |format|
            format.html # leaderboard.html.erb
          end
        else
          flash[:notice] = "You need to login."
          redirect_to root_path
        end
      end
    end
  end

  group_views :leaderboard, :activity, :combined

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

      if @group.save
        if params[:emails]
          EmailsWorker.perform_async(@group.id, params[:emails])
        end

        redirect_to @group
      else
        redirect_to new_group_path
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
      @group = Group.find(params[:groupid])
      @achievements = @group.get_recent_achievements(params[:latest])
      respond_to do |format|
        format.json { render json: @achievements }
      end
    else
      redirect_to root_path
    end
  end
end
