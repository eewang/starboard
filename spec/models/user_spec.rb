require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  
  it "is invalid without a name" do
    FactoryGirl.build(:user, name: nil).should be_valid
  end

  it "returns a profile picture" do
    user = FactoryGirl.create(:user)
    user.get_profile_pic_from_email("dannyolinsky@gmail.com")
  end

  it "can retrieve data" do
    user = FactoryGirl.create(:user, treehouse_username: "dannyolinsky", codeschool_username: "dolinsky", github_username: "dolin", blog_url: "http://dolin.github.com/atom.xml")
    user.get_external_data
  end


end