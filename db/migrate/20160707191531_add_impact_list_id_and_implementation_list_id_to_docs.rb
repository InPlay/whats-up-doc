class AddImpactListIdAndImplementationListIdToDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :docs, :impact_list_id, :integer
    add_column :docs, :implementation_list_id, :integer
  end
end
