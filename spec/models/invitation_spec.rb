require 'spec_helper'

describe Invitation do
  it "can generate a token" do
    invitation = FactoryGirl.create(:invitation)
    invitation.generate_token.should be_true
  end
end