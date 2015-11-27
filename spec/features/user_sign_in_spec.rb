require 'spec_helper'

feature 'User signs in' do 
  user = Fabricate(:user)
  
  scenario "with exisiting username and password" do
    visit sign_in_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    page.should have_content(user.full_name)
  end
end