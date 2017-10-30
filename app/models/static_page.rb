class StaticPage < ApplicationRecord
  enum markup_type: { markdown: 'markdown', html: 'html' }

  validates :slug, :markup_type, presence: true
end
