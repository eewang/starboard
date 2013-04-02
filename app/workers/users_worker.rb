class UsersWorker

  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.get_external_data
    user.get_profile_pic
  end

end 