class Page < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_ancestry

  validates :name, presence: true, format: { with: /\A[а-яА-ЯёЁa-zA-Z0-9_]+\z/ }
  validates :title, presence: true
  validates :content, presence: true

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
