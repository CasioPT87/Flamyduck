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

    it "sorts scenarios with drag and drop", :js do
      visit "/cheatsheets/#{subject.id}"
      first_scenario = scenarios(:bash)
      second_scenario = scenarios(:build)

      source = find('p', text: first_scenario.content)
      target = find('p', text: second_scenario.content)

      source.drag_to(target)

      expect(page.body.index(first_scenario.content)).to be < page.body.index(second_scenario.content)
    end

    it "scenarios keep sorted after page refreshes", :js do
      visit "/cheatsheets/#{subject.id}"
      first_scenario = scenarios(:bash)
      second_scenario = scenarios(:build)

      source = find('p', text: first_scenario.content)
      target = find('p', text: second_scenario.content)

      source.drag_to(target)

      page.driver.browser.navigate.refresh

      expect(page.body.index(first_scenario.content)).to be < page.body.index(second_scenario.content)
    end
  end

  context "Create scenario" do

    it "adds scenario at the bottom of the list" do
      visit "/cheatsheets/#{subject.id}"

      all_scenarios = all('.o-container-scenario-droppable .o-wrapper-scenario')
      expect(all_scenarios.count).to be(2)

      first_scenario = scenarios(:bash)
      second_scenario = scenarios(:build)

      subject.order_scenarios = "#{first_scenario.id},#{second_scenario.id}"
      subject.save

      add_button = find('.e-image-scenario-add').click
      fill_in('content for new scenario', with: 'whatever content for the scenario')
      click_button 'Create'

      all_scenarios = all('.o-container-scenario-droppable .o-wrapper-scenario')
      expect(all_scenarios.count).to be(3)

      scenario_created = subject.scenarios.last

      expect(page.body.index(scenario_created.content)).to be > page.body.index(second_scenario.content)
      expect(page.body.index(scenario_created.content)).to be > page.body.index(first_scenario.content) 
    end
  end

  context "Delete scenario" do

    it "removes scenario from list", js: true do
      visit "/cheatsheets/#{subject.id}"

      all_scenarios_beginning = all('.o-container-scenario-droppable .o-wrapper-scenario')
      expect(all_scenarios_beginning.count).to be(2)

      first_row = first('.o-wrapper-scenario')
      first_row.hover

      within(first_row) {
        click_on('delete scenario')
      }

      all_scenarios_end = all('.o-container-scenario-droppable .o-wrapper-scenario')
      expect(all_scenarios_end.count).to be(1)    
    end
  end

  context "Edit scenario" do

    it "changes scenario", js: true do
      visit "/cheatsheets/#{subject.id}"

      first_row = first('.o-wrapper-scenario')
      first_row.hover

      within(first_row) {
        find("img[alt='edit scenario']").click
      }

      first('#scenario_content').set('this is new content')
      click_on('Update')

      edited_scenario = find('p', text: 'this is new content')

      all_scenarios_end = all('.o-container-scenario-droppable .o-wrapper-scenario')
      expect(!!edited_scenario).to be(true)
    end
  end
end