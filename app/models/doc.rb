class Doc < ApplicationRecord
  has_many :items
  belongs_to :impact_list, class_name: 'Doc::List'
  belongs_to :implementation_list, class_name: 'Doc::List'

  before_create :generate_slug

  def to_param
    slug
  end

  def whats_next
    positions_by_item.keys
  end

  def as_chart
    positions_by_item.map do |(item, positions)|
      {
        text: item.content,
        x: positions[1],
        y: positions[0]
      }
    end
  end

  private

  def positions_by_item
    @positions_by_item ||= [impact_list, implementation_list].inject({}) do |acc, list|
      list.positions.each do |position|
        acc[position.item] ||= []
        acc[position.item] << position.position
      end
      acc
    end.
    sort_by {|(_item, positions)| positions.sum}.to_h
  end

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(24)
  end
end
