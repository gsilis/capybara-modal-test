require 'spec_helper'

feature 'Pretty list items index' do

  let!(:pretty_list_items) { Fabricate.times 4, :pretty_list_item }

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
    visit '/'

    first_list_item = pretty_list_items.first
    click_link 'Remove', href: pretty_list_item_path(first_list_item)

    expect(page).to_not have_css("#pretty_list_item_#{first_list_item.id}")
    expect(page).to have_text("'#{first_list_item.name}' was removed from the list.")
  end

end
