require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "displays login option" do
    
    visit '/'

    expect(page).to have_current_path(root_path)
  end
end