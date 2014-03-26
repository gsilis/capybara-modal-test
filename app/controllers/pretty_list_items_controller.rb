class PrettyListItemsController < ApplicationController
  before_action :fetch_pretty_list_items
  before_action :fetch_pretty_list_item, only: [:destroy]

  def index
  end

  def destroy
    if @list_item.destroy
      flash.now[:notice] = t('activerecord.flash.pretty_list_item.destroy.notice', name: @list_item.name)
    end

    respond_to do |format|
      format.js
    end
  end

  private
    def fetch_pretty_list_items
      @list_items = PrettyListItem.all
    end

    def fetch_pretty_list_item
      @list_item = PrettyListItem.find params[:id]
    end
end
