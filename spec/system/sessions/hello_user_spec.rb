require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  
  context 'Trying to log in' do

    it "succeeds" do 
      visit '/login'

      fill_in('Name', with: 'Sergio')
      fill_in('Password', with: 'Pasodeti99')
      click_button('Log in')

      expect(page).to have_current_path(root_path)
      expect(page).to have_selector('p', text: 'Hi, Sergio')
    end
  end
end