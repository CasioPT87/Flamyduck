require 'rails_helper'

RSpec.describe "logged/cheatsheets/show.html.erb", type: :view do

  before(:each) {
    visit login_path
    fill_in('Name', with: "Sergio")
    fill_in('Password', with: "Pasodeti99")
    click_button "Log in"
  }

  subject { cheatsheets(:docker_compose) }

  context "When start without group" do

    it "displays all scenarios" do
      visit "/cheatsheets/#{subject.id}"
      expect(page).to have_selector('p', text: 'docker-compose exec web bash')
      expect(page).to have_selector('p', text: 'docker-compose build')
    end
  end

  context "When start with group" do

    it "displays all scenarios" do
      group = groups(:docker)
      visit "groups/#{group.id}/cheatsheets/#{subject.id}"
      expect(page).to have_selector('p', text: 'docker-compose exec web bash')
      expect(page).to have_selector('p', text: 'docker-compose build')
    end

    it "displays all cheatsheets of the group" do
      group = groups(:docker)
      visit "groups/#{group.id}/cheatsheets/#{subject.id}"
      expect(page).to have_selector('a', text: subject.name)
      expect(page).to have_selector('a', text: cheatsheets(:docker).name)
    end
  end

  context "order of scenarios" do

    it "displays scenarios in initial order" do
      visit "/cheatsheets/#{subject.id}"
      first_scenario = scenarios(:bash)
      second_scenario = scenarios(:build)

      expect(page.body.index(second_scenario.content)).to be < page.body.index(first_scenario.content)
    end
  end

  # context "Click 'edit' button" do

  #   it "directs to edit cheatsheet page" do
  #     visit '/cheatsheets'
  #     docker_compose_cheatsheet_row = first('.o-wrapper-cheatsheets')
  #     within(docker_compose_cheatsheet_row) do
  #       click_link('edit')
  #     end
  #     first_cheatsheet = cheatsheets(:docker_compose)
  #     expect(page).to have_current_path("/cheatsheets/#{first_cheatsheet.id}/edit")
  #   end
  # end
end