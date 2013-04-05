class ApplicationController < ActionController::Base
  protect_from_forgery

  def instantiate_achievement
    @achievement = Achievement.new
  end

private

  def current_user
    unless User.where(:id => session[:user_id]).empty?
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  helper_method :current_user
  
  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

end
