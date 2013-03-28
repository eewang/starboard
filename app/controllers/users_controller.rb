class UsersController < ApplicationController

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
    @user = User.find(params[:id])
    @achievements = @user.achievements
    @messages = @user.achievements.collect do |achievement|
      achievement.message
    end.compact

    @treehouse_stars = @user.stars.where(:source_id => 1)
    @codeschool_stars = @user.stars.where(:source_id => 2)
    @github_stars = @user.stars.where(:source_id => 3)
    @blog_stars = @user.stars.where(:source_id => 4)
    gifted_star_id = Star.where(:name => "Gifted Star").first.id
    @gifted_stars = @user.achievements.where(:star_id => gifted_star_id)
    @teacher_stars = Star.where(:source_id => 5)
    @stars_from_teacher = @user.stars.where(:source_id => 5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.get_profile_pic
   @user.giftable_star_bank = 2

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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

  # def set_as_teacher(user)
  #   user.is_teacher = true
  # end

  # /users/:id
  def give_star
    if current_user.can_give_star?
      user = User.find(params[:id])
      current_user.give_achievement_to(user, params[:message])
    end
    redirect_to user
  end

  # /users/refill_star_bank/:id
  def refill_star_bank
    if current_user.is_teacher?
      @user = User.find(params[:id])
      @user.giftable_star_bank = 0 if @user.giftable_star_bank.nil? 
      @user.giftable_star_bank = @user.giftable_star_bank + params[:star_bank].to_i
      @user.save
      redirect_to @user
    end
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
    # a user authorized as a teacher can create a new star type.
    # the source of these stars will be "Teacher".


end
