require 'spec_helper'

feature 'Pretty list items index' do

  let!(:pretty_list_items) { Fabricate.times 4, :pretty_list_item }
  let!(:valid_params) { { name: Faker::Name.name, description: Faker::Lorem.paragraph } }

  scenario 'it displays the pretty list items properly' do
    visit '/'

    expect(page).to have_text('Pretty List Items')
    expect(page).to have_link('Add', href: new_pretty_list_item_path)

    pretty_list_items.each do |item|
      expect(page).to have_selector("#pretty_list_item_#{item.id}")
      expect(page).to have_text(item.name)
      expect(page).to have_link('Edit', href: edit_pretty_list_item_path(item))
      expect(page).to have_link('Remove', href: pretty_list_item_path(item))
    end
  end

  scenario 'it removes the item from the page', :js => true do
    first_list_item = pretty_list_items.first

    visit '/'
    click_link 'Remove', href: pretty_list_item_path(first_list_item)

    expect(page).to_not have_css("#pretty_list_item_#{first_list_item.id}")
    expect(page).to     have_text("'#{first_list_item.name}' was removed from the list.")
  end

  scenario 'it can add new list items', js: true do
    visit '/'

    click_link    'Add',          href: new_pretty_list_item_path
    fill_in       'Name',         with: valid_params[:name]
    fill_in       'Description',  with: valid_params[:description]
    click_button  'Save'

    expect(page).to     have_xpath("//div[@class=\"pretty-list\"]/ul/li[last()]/span", text: valid_params[:name])
    expect(page).to     have_text("'#{valid_params[:name]}' was added to the list.")
    expect(page).to_not have_selector('.modal-backdrop')
    expect(page).to_not have_selector('.modal.in')
  end

  scenario 'it displays the modal properly when validations errors occur', js: true do
    visit '/'

    click_link 'Add', href: new_pretty_list_item_path
    click_button 'Save'

    expect(page).to     have_text('Item Name can\'t be blank')
    expect(page).to     have_selector('.modal-backdrop', count: 1)
    expect(page).to_not have_text('Sort order is not a number')
  end

end
