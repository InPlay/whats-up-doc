require 'rails_helper'

feature 'Understanding what to do next in life', :js do
  before do
    page.driver.browser.manage.window.resize_to 320, 568 # iPhone 5
  end

  after do
    page.driver.browser.manage.window.resize_to 1200, 800 # desktop
  end

  scenario 'a mobile user walks through the discernment process' do
    create_doc('Saving the World')

    add_item('Run for president')
    add_item('Watch a documentary')
    add_item('Spread sustainable agriculture')
    add_item('Fight pirates')
    add_item('End poverty')

    click_button 'Next'

    # impact
    move_item('Fight pirates', below: 'Run for president')
    move_item('Watch a documentary', below: 'Fight pirates')
    move_item('End poverty',   below: 'Spread sustainable agriculture')

    click_button 'Next'

    # implementation
    move_item('End poverty', below: 'Run for president')
    move_item('Fight pirates', below: 'Spread sustainable agriculture')
    move_item('Spread sustainable agriculture', below: 'Watch a documentary')

    click_button 'Next'

    # recommendation
    expect(page).to have_content("Here's What's Up!")
    expect(all('.tab-pane.active li').map(&:text)).to eq([
      "Spread sustainable agriculture",
      "Fight pirates",
      "End poverty",
      "Run for president",
      "Watch a documentary"
    ])
  end

  def create_doc(title)
    visit root_path

    fill_in 'doc_title', with: 'Saving the World'
    click_button 'Create Doc'

    expect(page.title).to have_content('Saving the World')
  end

  def add_item(title)
    fill_in('doc_add_item_content', with: title)
    click_button('Add')

    within('.items') { expect(page).to have_content(title) }
  end

  def move_item(title, below:)
    item = page.find('.item', text: title)
    below_item = page.find('.item', text: below)
    while item.path < below_item.path
      within(item) { find('.move-down').click }
      item = page.find('.item', text: title)
      below_item = page.find('.item', text: below)
    end
  end
end
