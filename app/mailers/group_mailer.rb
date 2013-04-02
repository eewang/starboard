class GroupMailer < ActionMailer::Base
  default from: "teamstarboard@gmail.com"

    # find invitation based off token in url string
    # for that invitation, find it's email and check if a user already exists with that email
    # if user already exists, redirect to a form that asks for username/pw with a submit button that says join group 
      # create association in group_user
    # if user doesn't exist, create a new user and make the association in users/groups

  def self.check_invitation(invitation, token)
    if User.where(:email => invitation.email).first
      user = User.where(:email => invitation.email).first
      GroupMailer.existing_user_invitation(user, invitation).deliver
    else
      @invitation = invitation
      GroupMailer.new_user_invitation(invitation, token).deliver
    end
  end

  def new_user_invitation(invitation, token)
    @token = token
    @invitation = invitation
    @sender = User.where(:id => invitation.sender_id).first
    @group = Group.where(:id => invitation.group_id).first
    mail(:to => invitation.email,
         :subject => "Join a Starboard Group")
  end

  def existing_user_invitation(user, invitation)
    @user = user
    @invitation = invitation
    @join_url = 'http://localhost:3000/group/join'
    @sender = User.where(:id => invitation.sender_id).first
    @group = Group.where(:id => invitation.group_id).first
    mail(:to => user.email,
         :subject => "Join a Starboard Group")
  end

end
