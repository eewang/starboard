class GroupsController < ApplicationController
  before_filter :instantiate_achievement

  # GET /groups
  # GET /groups.json
  def index
    unless current_user
      redirect_to '/login'
    elsif current_user.is_teacher?
      redirect_to current_user
    else
      redirect_to "/groups/#{current_user.groups.first.id}/leaderboard"
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @users = Group.find(params[:id]).users
    redirect_to "/groups/#{params[:id]}/leaderboard"
  end

  def self.group_views(*views)
    views.each do |view|
      define_method "#{view}" do

        unless current_user
          user = User.where(:email => "demo@gmail.com").first
          session[:user_id] = user.id
        end

        @active_nav = view.to_s
        @group = Group.find(params[:id])
        users = User.joins(:groups).where("group_id = #{params[:id]}").sort_by { |user| user.achievements.count }.reverse
        @users = users.delete_if { |u| u.email == "demo@gmail.com" }
        if view == :blog_posts
          user_ids = @group.user_ids
          @blog_posts = Achievement.where(:user_id => (user_ids), :star_id => 2).order('created_at ASC')
        end
        respond_to do |format|
          format.html # leaderboard.html.erb
        end
      end
    end
  end

  group_views :leaderboard, :activity, :combined, :stats, :blog_posts

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
      flash[:alert] = "Log in first."
      redirect_to new_session_path
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
        flash[:success] = "Group created, emails are on their way out!"
        redirect_to "/groups/#{@group.id}/leaderboard"
      else
        flash[:alert] = "Sorry, group didn't save..."
        redirect_to new_group_path
      end
    else 
      flash[:alert] = "Log in first."
      redirect_to new_session_path
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        if params[:emails]
          EmailsWorker.perform_async(@group.id, params[:emails])
          format.html { redirect_to current_user, notice: 'Invitations successfully sent.' }
        else
          format.html { redirect_to @group, notice: 'Group was successfully updated.' }
          format.json { head :no_content }
        end
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
