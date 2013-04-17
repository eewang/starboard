class TreehouseWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform
    User.all.each do |user|
      begin
        badges = TreehouseChart.update_badges(user)
        unless user.update_attribute(:thbadges, badges.join(", "))
          puts Rails.logger.info(user.errors.messages.inspect)
        end
      rescue
        next
      end
    end
  end

end