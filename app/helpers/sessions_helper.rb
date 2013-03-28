module SessionsHelper

  def is_current_user_profile?
    current_user.id == params[:id].to_i
  end

  def current_user_is_teacher?
    current_user.is_teacher
  end

end
