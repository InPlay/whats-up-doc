require 'rails_helper'

feature 'Doc creation' do
  scenario 'anon user creates a new doc' do
    visit root_path

    fill_in 'doc_title', with: 'My New Doc'
    click_button 'Create Doc'

    expect(page).to have_content('My New Doc')
  end
end
