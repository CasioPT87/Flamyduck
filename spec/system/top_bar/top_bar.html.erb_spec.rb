require 'rails_helper'

RSpec.describe "_top_bar.html.erb", type: :view do

  def sign_up_valid
    visit new_user_path
    fill_in('Name', with: "Pepino")
    fill_in('Password', with: "Kedisetu88")
    fill_in('Email', with: "email@thisemailhasntbeentaken.com")
    click_button "Create User"
  end

  def sign_up_not_valid
    visit new_user_path
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "")
    click_button "Create User"
  end

  def login_valid
    visit login_path
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "Pasodeti99")
    click_button "Log in"
  end

  def login_not_valid
    visit login_path
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "AnotherPassword000")
    click_button "Log in"
  end

  context "Sign up" do

    it "succeeds" do
      sign_up_valid

      screenshot_and_save_page
      
      expect(page).to have_selector('.c-flash--notice', text: 'User created successfuly')
    end
  
    it "fails" do
      sign_up_not_valid
      expect(page).to have_selector('.c-flash--alert', text: "Password can't be blank, Password Password must be within 6 and 15 characters, Password Password must be within 6 and 15 characters, Password password can't be empty, Email can't be blank, Email is invalid")
    end

  end

  context "Login" do
    
    it "succeds" do
      sign_up_valid
      click_link "Logout"
      login_valid
      expect(page).to have_selector('.c-flash--notice', text: 'Logged successfuly')
    end
  
    it "fails" do
      sign_up_valid
      click_link "Logout"
      login_not_valid
      expect(page).to have_selector('.c-flash--alert', text: 'Name or password not correct')
    end    
  end
end