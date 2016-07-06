class Doc < ApplicationRecord
  has_many :items
  has_many :sorted_lists

  before_create :generate_slug

  def to_param
    slug
  end

  def whats_next
    sorted_lists.inject({}) do |acc, list|
      list.positions.each do |position|
        acc[position.item] ||= []
        acc[position.item] << position.position
      end
      acc
    end.
    sort_by {|(_item, positions)| positions.sum}.
    map(&:first)
  end

  private

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(24)
  end
end
