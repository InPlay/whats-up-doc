require 'rails_helper'

feature 'Interacting with a doc' do
  let(:doc) { Doc.create(title: 'Next Up') }

  scenario 'a user adds an item to be prioritized' do
    visit doc_path(doc)

    fill_in 'new_item_content', with: 'Lorem ipsum'
    click_button 'Add Item'

    within('#list_1') { expect(page).to have_content('Lorem ipsum') }
    within('#list_2') { expect(page).to have_content('Lorem ipsum') }
  end
end
