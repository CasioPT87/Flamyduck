require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "displays login option" do
    
    visit '/login'

    fill_in('Name', with: 'Sergio')
    fill_in('Password', with: 'Pasodeti99')
    click_button('Log in')

    expect(page).to have_current_path(root_path)

    expect(page).to have_selector('p', text: 'Hi, Sergio')
  end
end