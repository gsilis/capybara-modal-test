class PrettyListItemsController < ApplicationController
  before_action :fetch_pretty_list_items
  before_action :fetch_pretty_list_item, only: [:edit, :destroy, :update]

  def new
    @list_item = PrettyListItem.new

    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def index
  end

  def create
    @list_item = PrettyListItem.new pretty_list_item_params

    if @list_item.save
      respond_to do |format|
        flash.now[:notice] = t('activerecord.flash.pretty_list_item.create.notice', name: @list_item.name)
        format.js
      end
    else
      respond_to do |format|
        format.js { render action: :new }
      end
    end
  end

  def update
    if @list_item.update_attributes pretty_list_item_params
      respond_to do |format|
        flash.now[:notice] = t('activerecord.flash.pretty_list_item.update.notice', name: @list_item.name)
        format.js
      end
    else
      respond_to do |format|
        format.js { render action: :edit }
      end
    end
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

    def pretty_list_item_params
      params[:pretty_list_item].permit(:name, :description)
    end
end
