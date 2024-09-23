class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_rich_text :body
end
