class EmailsWorker

  include Sidekiq::Worker

  def perform(group_id, params)
    group = Group.find(group_id)

    emails = params[:emails].split(', ').collect
    emails.each do |email|
      invitation = group.invitations.build
      invitation.email = email.strip
      invitation.generate_token # method in invitations model
      invitation.sender_id = current_user.id

      group.invitations << invitation
      GroupMailer.check_invitation(invitation, join_url(invitation.token))
    end
  end

end 