class Doc::AddingItem < Doc
  include Gerund

  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :impact_list
  accepts_nested_attributes_for :implementation_list

  def add_item=(attrs = {})
    return if attrs[:content].blank?
    add_item_to_top_of_all_lists(items.create(attrs))
  end

  private

  def add_item_to_top_of_all_lists(item)
    max_impact_position = impact_list.positions.last&.position || -1
    impact_list.positions.create(item: item, position: max_impact_position + 1)
    implementation_list.positions.create(item: item, position: 0)
  end
end
