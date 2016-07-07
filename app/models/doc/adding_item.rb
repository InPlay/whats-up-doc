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
    [impact_list, implementation_list].each do |list|
      list.positions.create(item: item, position: -1)
      list.positions.update_all("position = position + 1")
    end
  end
end
