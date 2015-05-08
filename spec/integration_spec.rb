require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Add a new stylist', {:type => :feature}) do
  it 'allows user to add a stylist' do
    visit ('/')
    click_link('Add a New Stylist')
    fill_in('stylist_name', :with => 'Jenny McShears')
    click_button('Add Stylist')
    expect(page).to have_content('Jenny McShears')
  end
end
