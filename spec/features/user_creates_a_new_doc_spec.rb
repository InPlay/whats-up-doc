require 'rails_helper'

feature 'Doc creation' do
  scenario 'anon user creates a new doc' do
    visit root_path
  end
end
