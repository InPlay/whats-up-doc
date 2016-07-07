class Doc::Item < ApplicationRecord
  has_many :positions, -> { order 'sorted_list_id' }, dependent: :destroy, class_name: 'Doc::SortedList::Position'
end
