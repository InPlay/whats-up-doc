class Doc::AddingItem < Doc
  include Gerund

  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :sorted_lists

  def add_item=(attrs = {})
    return if attrs[:content].blank?
    add_item_to_top_of_all_sorted_lists(items.create(attrs))
  end

  private

  def add_item_to_top_of_all_sorted_lists(item)
    sorted_lists.each do |list|
      list.positions.create(item: item, position: -1)
      list.positions.update_all("position = position + 1")
    end
  end
end
