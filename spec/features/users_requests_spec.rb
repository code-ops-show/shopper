require 'spec_helper'

feature "Users Requests" do
  given(:user) { Member.make! }

  before do
    login user
    visit edit_user_registration_path
  end

  scenario "should edit user" do
    fill_in "user_name", with: "Bot 001"
    fill_in "user_email", with: "bot001@test.com"
    fill_in "user_bio", with: "bot biography"
    click_button 'Update'

    visit edit_user_registration_path
    page.should have_content "Bot 001"
    page.find(:css, "#user_email").value.should == "bot001@test.com"
    page.should have_content "bot biography"
  end

  scenario "should upload avatar" do
    attach_file "user_avatar", Rails.root.join('public', 'artellectual.png')
    click_button 'Update'

    visit edit_user_registration_path
    page.should have_css "img[alt='Thumb_artellectual']"
    page.should_not have_css "img[alt='Thumb_default']"
  end
end