class Doc < ApplicationRecord
  has_many :items
  has_many :sorted_lists

  before_create :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(24)
  end
end
