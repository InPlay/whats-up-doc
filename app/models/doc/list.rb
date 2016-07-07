class Doc::SortedList < ApplicationRecord
  has_many :positions, -> { order 'position' }
  has_many :items, through: :positions

  accepts_nested_attributes_for :positions
end
