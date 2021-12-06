class Page < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_ancestry

  validates :name, presence: true, format: { with: /\A[a-zA-Zа-яА-Я0-9_]+\z/ }
  validates :title, presence: true
  validates :content, presence: true
 
  def normalize_friendly_id(input)
    name_as_slug  = input.to_s.to_slug.normalize(transliterations: :russian).to_s  
    if parent.present?
      self.slug = [parent.slug, (slug.blank? ? name_as_slug  : slug.split('/').last)].join('/')
    else
      self.slug = name_as_slug
    end
  end

end
