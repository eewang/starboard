class GroupMailer < ActionMailer::Base
  default from: "teamstarboard@gmail.com"

  def welcome_invitation(invitation, join_url)
    @join_url = join_url
    @invitation = invitation
    mail(:to => invitation.email,
         :subject => "Join a Starboard Group")
  end

end
