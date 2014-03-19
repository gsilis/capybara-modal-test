class ChangePrettyListTitleToName < ActiveRecord::Migration
  def change
    rename_column :pretty_list_items, :title, :name
  end
end
