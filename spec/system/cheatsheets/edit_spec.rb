require 'rails_helper'

RSpec.describe "logged/cheatsheets/edit.html.erb", type: :view do

  before(:each) {
    visit login_path
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "Pasodeti99")
    click_button "Log in"
  }

  context "Cheatsheet list" do

    it "displays all cheatsheets" do
      visit '/cheatsheets'
      expect(page).to have_selector('a', text: 'docker-compose')
      expect(page).to have_selector('a', text: 'docker')
    end
  end

  context "Click 'Create' button" do

    it "directs to new cheatsheet page form" do
      visit '/cheatsheets'
      click_button('Create New')
      expect(page).to have_current_path('/cheatsheets/new')
    end
  end

  context "Click 'delete' button" do

    it "deletes cheatsheet from page" do
      visit '/cheatsheets'
      docker_compose_cheatsheet_row = first('.list')
      within(docker_compose_cheatsheet_row) do
        click_link('delete')
      end
      
      expect(page).not_to have_selector('a', text: 'docker-compose')
      expect(page).to have_selector('a', text: 'docker')
    end
  end

  context "Click 'edit' button" do

    it "directs to edit cheatsheet page" do
      visit '/cheatsheets'
      docker_compose_cheatsheet_row = first('.list')
      within(docker_compose_cheatsheet_row) do
        click_link('edit')
      end
      
      expect(page).to have_current_path('/cheatsheets/1/edit')
    end
  end
end