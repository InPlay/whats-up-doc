class CreateDocSortedLists < ActiveRecord::Migration[5.0]
  def change
    create_table :doc_sorted_lists do |t|
      t.string :title
      t.string :max_in_words
      t.string :min_in_words
      t.integer :doc_id
    end
  end
end
