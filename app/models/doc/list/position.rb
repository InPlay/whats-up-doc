class Doc::SortedList::Position < ApplicationRecord
  belongs_to :item
  belongs_to :sorted_list
end
