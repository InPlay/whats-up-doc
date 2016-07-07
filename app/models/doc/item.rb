class Doc::Item < ApplicationRecord
  has_many :positions, -> { order 'list_id' }, dependent: :destroy, class_name: 'Doc::List::Position'
end
