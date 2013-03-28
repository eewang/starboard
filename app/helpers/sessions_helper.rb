module SessionsHelper

  def is_current_user?
    current_user.id == params[:id].to_i
  end
end
