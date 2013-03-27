class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users_array = self.class.users_for_grid

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
    @gitub_stars = @user.stars.where(:source_id => 3)
    @blog_stars = @user.stars.where(:source_id => 4)
    given_star_id = Star.where(:name => "Gifted Star").first.id
    @given_stars = @user.achievements.where(:star_id => given_star_id)

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
    @user.reset_giftable_star_bank

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

  def self.users_for_grid
    all_users = User.all
    users = Array.new(all_users.size / 6)
    # => [nil, nil, nil, nil] if there were 24 users for example...

    users.collect do |user|
      all_users.shift(6)
    end
  end

  # /users/give_star/:id
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
      @user.increment(:giftable_star_bank)
      redirect_to @user
    end
  end

  def create_teacher_star
    # a user authorized as a teacher can create a new star type.
    # the source of these stars will be "Teacher".
  end

end
