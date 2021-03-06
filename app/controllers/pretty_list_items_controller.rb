class PrettyListItemsController < ApplicationController
  before_action :fetch_pretty_list_items,           only: [:index, :create, :update, :reorder]
  before_action :fetch_pretty_list_item,            only: [:edit, :destroy, :update]
  before_action :ensure_type_of_reorder_ids_param,  only: [:reorder]

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

  def reorder
    pretty_list_item_ids_params.each_with_index do |item_id, index|
      item = PrettyListItem.find(item_id)
      item.update_columns sort_order: index + 1
    end

    flash.now[:notice] = t('activerecord.flash.pretty_list_item.reorder.notice')

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

    def pretty_list_item_ids_params
      params[:pretty_list_item_ids]
    end

    def ensure_type_of_reorder_ids_param
      head 422 unless params[:pretty_list_item_ids].is_a? Array
    end
end
