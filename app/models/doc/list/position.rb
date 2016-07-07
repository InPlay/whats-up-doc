class Doc::List::Position < ApplicationRecord
  belongs_to :item
  belongs_to :list
end
