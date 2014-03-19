class PrettyListItemsController < ApplicationController
  before_action :fetch_pretty_list_items

  def index
  end

  private
    def fetch_pretty_list_items
      @list_items = PrettyListItem.all
    end
end
