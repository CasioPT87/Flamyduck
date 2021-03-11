require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do

  context "User not logged in" do

    it "displays login button" do
      visit '/'
      click_link 'Login'
      expect(page).to have_current_path(login_path)
    end
  
    it "displays sign up button" do
      visit '/'
      click_link 'Sign Up'
      expect(page).to have_current_path(new_user_path)
    end

  end

  context "User is logged in" do

    def sign_up
      visit '/'
      click_link 'Sign Up'
      fill_in('Name', with: "Sergio")
      fill_in('Password', with: "Whatever000")
      fill_in('Email', with: "a@thisemaildoesntexistsyet.com")
      
      click_button "Create User"
    end

    before(:each) do
      sign_up
    end
    
    it "displays cheatsheets button" do
      screenshot_and_save_page
      click_link 'Cheatsheets'
      expect(page).to have_current_path(cheatsheets_path)
    end
  
    it "displays groups button" do
      click_link 'Groups'
      expect(page).to have_current_path(groups_path)
    end
    
  end
end