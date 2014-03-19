require 'spec_helper'

feature 'Pretty list items index' do

  let!(:pretty_list_items) { Fabricate.times 4, :pretty_list_item }

  scenario 'it displays the pretty list items properly' do
    visit '/'

    expect(page).to have_text('Pretty List Items')
    pretty_list_items.each do |item|
      expect(page).to have_text(item.name)
    end
  end

end
