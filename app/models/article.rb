class Article < ActiveRecord::Base
	belongs_to :category
	validates :title, presence: true, length: { maximum: 30 }
	validates :content, presence: true
	validates :category, presence: true

	scope :newest, -> { order(created_at: :desc) }
end
