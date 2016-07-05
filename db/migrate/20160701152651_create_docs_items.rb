class CreateDocsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :doc_items do |t|
      t.integer :doc_id
      t.text :content

      t.timestamps
    end
  end
end
