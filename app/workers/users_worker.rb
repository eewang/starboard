class UsersWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  REDIS_POOL = ConnectionPool.new(:size => 5, :timeout => 3) { Redis.new }

  def perform(user_id, service, identifier)
      user = User.find(user_id)
      service_object = service.classify.constantize.new
      array = service_object.get_data(identifier)
      user.check_achievements_by_array(array, service.to_s)
  end

end