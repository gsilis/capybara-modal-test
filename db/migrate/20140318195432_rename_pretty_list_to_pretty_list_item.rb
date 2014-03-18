class RenamePrettyListToPrettyListItem < ActiveRecord::Migration
  def change
    rename_table :pretty_lists, :pretty_list_items
  end
end
