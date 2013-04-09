class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(:email => params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
        unless params[:invitation_token].empty?
          redirect_to group_signup_url(:invitation_token => params[:invitation_token])
        else
          flash[:success] = "Logged in!"
          redirect_to root_url
        end
    else
      flash[:alert] = "Email or Password is invalid."
      render "new"
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_url
  end

end
