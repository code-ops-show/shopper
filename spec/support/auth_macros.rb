module AuthMacros
  def login user
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "secretssss"
    click_button "Sign in"
  end
end