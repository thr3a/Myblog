class Article < ActiveRecord::Base
	belongs_to :category
	validates :title, presence: true, length: { maximum: 30 }
	validates :content, presence: true
	validates :category, presence: true

	scope :recent, -> { order(created_at: :desc) }
	scope :fetchpage, ->(page) { paginate(page: page, per_page: 5)}
end
