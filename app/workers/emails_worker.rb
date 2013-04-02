class EmailsWorker

  include Sidekiq::Worker
  # sidekiq_options retry: false

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