class EmailsWorker

  include Sidekiq::Worker
    sidekiq_options queue: "email"
    # sidekiq_options retry: false

  REDIS_POOL = ConnectionPool.new(:size => 5, :timeout => 3) { Redis.new }

  def perform(group_id, emails)
    group = Group.find(group_id)
    
    emails.split(', ').each do |email|
      invitation = group.invitations.build
      invitation.email = email.strip
      invitation.generate_token 
      invitation.sender_id = group.creator_id

      group.invitations << invitation
      GroupMailer.check_invitation(invitation, invitation.token)
    end
  end

end 