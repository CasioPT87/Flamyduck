require 'rails_helper'

RSpec.describe "logged/groups/index.html.erb", type: :view do

  before (:each) {
    visit '/login'
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "Pasodeti99")
    click_button "Log in"
  }

  context "Group list" do

    it "displays all groups" do
      visit '/groups'
      expect(page).to have_selector('a', text: 'docker')
      expect(page).to have_selector('a', text: 'rails')
    end
  end

  context "Click 'Create' button" do

    it "directs to new group page form" do
      visit '/groups'
      click_button('Create New Group')
      expect(page).to have_current_path('/groups/new')
    end
  end

  context "Click 'delete' button", js: true do

    it "deletes group from page", js: true do
      sleep(1)
      visit '/groups'

      first('#toggle').click
      first('#delete').click

      page.accept_alert

      expect(page).to have_selector('a', text: 'docker')
      expect(page).not_to have_selector('a', text: 'rails')
    end
  end

  context "Click 'edit' button" do

    it "directs to edit cheatsheet page" do
      visit '/groups'
      docker_group_row = first('.list')
      within(docker_group_row) do
        click_link('edit')
      end
      group_id = Group.first.id
      
      expect(page).to have_current_path("/groups/#{group_id}/edit")
    end
  end
end