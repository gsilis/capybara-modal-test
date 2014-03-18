class CreatePrettyLists < ActiveRecord::Migration
  def change
    create_table :pretty_lists do |t|
      t.string    :title
      t.text      :description
      t.integer   :sort_order
      t.timestamps

      t.index     :sort_order
    end
  end
end
