class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(:email => params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
        if params[:invitation_token]
          redirect_to group_signup_url(:invitation_token => params[:invitation_token])
        else
          redirect_to root_url, notice: "Logged in!"
        end
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

end
