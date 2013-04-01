class TeachersController < ApplicationController
  
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    @user.is_teacher = true
    @user.get_profile_pic

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'Teacher was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.is_teacher?
      @groups = Group.where(:creator_id => params[:id])
      render 'users/show'
    else
      redirect_to @user
    end

    

    # respond_to do |format|
    #   format.html '/users/show.html.erb'
    #   format.json { render json: @user }
    # end
  end

end
