class UsersController < ApplicationController

  before_filter :instantiate_achievement
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user
      @user = User.find(params[:id])
      @teacher_groups = Group.where(:creator_id => current_user.id)

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to root_path
    end
  end

  def self.user_views(*views)
    views.each do |view|
      define_method "#{view}" do
        if current_user
          @active_nav = view.to_s
          @user = User.find(params[:id])
          @star_types = views.collect { |type| type.to_s }

          respond_to do |format|
            format.html
            format.json { render json: @user }
          end
        end
      end
    end
  end

  user_views :show, :blog, :codeschool, :github, :handraise, :student, :teacher, :treehouse

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def join
    @invitation = Invitation.where(:id )
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    unless current_user && @user.id == current_user.id
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.giftable_star_bank = 2
    
    unless params[:invitation_token].empty?
      group_id = Invitation.find_group_by_token(params[:invitation_token]).id
      @user.group_users.build(:group_id => group_id)
    end

    respond_to do |format|
      if @user.save
        
        session[:user_id] = @user.id
        format.html { redirect_to edit_user_path(@user), notice: 'Thanks for signing up! Update your information to start getting some stars!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    # redirect to edit
    # some of the above stuff move to update
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.get_external_data
        @user.save
        format.html { redirect_to @user, notice: "Your stars are traveling through space to get here. Refresh your page in a few seconds!" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def remove_from_group
    @user = User.find_by_id(params[:user])
    @group = Group.find_by_id(params[:group])
    @group_user = GroupUser.where(:user_id => @user, :group_id => @group)
    @group_user.first.delete
    @user.save

    render :nothing => true
  end

  def give_star
    if current_user.can_give_star?
      user = User.find(params[:id])
      current_user.give_achievement_to(user, params[:message])
    end
    redirect_to user
  end

  def create_teacher_star
    if current_user.is_teacher?
      @user = User.find(params[:id])
      source_id = Source.where(:name => "Teacher").first.id
      star = Star.where(:source_id => source_id).find_or_create_by_name(:name => params[:name])
      @user.achievements.create(:star_id => star.id)
      redirect_to @user
    end
  end

  # GET /refill_star_bank
  def refill_star_bank
    if params[:group_id].present?
      @group = Group.find(params[:group_id])
      @users = @group.users
    end

    render :layout => false
  end

  # POST /refill_star_bank_create
  def refill_star_bank_create
    params[:user_names].each do |user_name|
      user = User.where(:name => user_name).first
      user.giftable_star_bank = 0 if user.giftable_star_bank.nil?
      user.giftable_star_bank = user.giftable_star_bank + params[:number].to_i
      user.save
    end

    respond_to do |f|
      f.js {}
      f.html {}
    end
  end

  def create #achievements
    @achievement = Achievement.new(params[:achievement])

    if params[:star_name]
      star_id = Source.teacher.stars.where(:name => params[:star_name]).first_or_create.id
      @achievement.star_id = Source.teacher.id
    else
      star_id = Star.where(:name => "Gifted Star").first.id
      @achievement.star_id = star_id
    end

    @achievement.sender_id = current_user.id
    @achievement.user_id = User.where(:name => params[:user_name]).first.id

    @achievement.save
      
    respond_to do |f|
      f.js {}
      f.html {}
    end
  end
end