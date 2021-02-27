require 'rails_helper'

RSpec.describe "logged/cheatsheets/index.html.erb", type: :view do

  def login_valid
    visit login_path
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "Pasodeti99")
    click_button "Log in"
  end

  context "Cheatsheet list" do

    it "displays all cheatsheets" do
      login_valid
      visit '/cheatsheets'
      screenshot_and_save_page
      expect(page).to have_selector('a', text: 'docker-compose')
      expect(page).to have_selector('a', text: 'docker')
    end

  end
end