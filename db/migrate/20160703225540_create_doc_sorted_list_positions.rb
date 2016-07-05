class CreateDocSortedListPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :doc_sorted_list_positions do |t|
      t.integer :item_id
      t.integer :sorted_list_id
      t.integer :position
    end
  end
end
