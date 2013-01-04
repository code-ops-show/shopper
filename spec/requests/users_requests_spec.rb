require 'spec_helper'

describe "Users Requests" do
  let(:user) { User.make! }

  before do
    login user
    visit edit_user_registration_path
  end

  it "should edit user" do
    fill_in "user_name", with: "Bot 001"
    fill_in "user_email", with: "bot001@test.com"
    fill_in "user_bio", with: "bot biography"
    click_button 'Update'

    visit edit_user_registration_path
    page.should have_content "Bot 001"
    page.find(:css, "#user_email").value.should == "bot001@test.com"
    page.should have_content "bot biography"
  end
end