class RenameDocSortedListsToDocLists < ActiveRecord::Migration[5.0]
  def change
    rename_table :doc_sorted_lists, :doc_lists
    rename_table :doc_sorted_list_positions, :doc_list_positions
    rename_column :doc_list_positions, :sorted_list_id, :list_id
  end
end
