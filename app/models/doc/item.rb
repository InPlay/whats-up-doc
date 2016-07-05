class Doc::Item < ApplicationRecord
  after_destroy :destroy_positions

  private

  def destroy_positions
    Doc::SortedList::Position.where(item_id: id).destroy_all
  end
end
