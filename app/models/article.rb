class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_rich_text :content

  def fmt_published
    created_at.fmt_long.capitalize
  end

  def fmt_updated
    updated_at.fmt_long.capitalize
  end
end
