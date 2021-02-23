require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "displays login option" do
    
    visit '/'

    click_button 'Login'

    expect(page).to have_current_path(login_path)
  end
end