class Article < ActiveRecord::Base

	belongs_to :category, foreign_key: "category_id"

	belongs_to :author, foreign_key: "author_id", primary_key: "uid"

	has_many :article_attachments
	accepts_nested_attributes_for :article_attachments

	validates :title, presence: true, length: { maximum: 50 }
	validates :content, presence: true
	validates :category, presence: true
	validates :author_id, presence: true
	validate :author_id, :authenticate_user

	scope :recent, -> { order(created_at: :desc) }
	scope :fetchpage, ->(page, per_page) { paginate(page: page, per_page: per_page)}

	private
	def authenticate_user
		if !Author.exists?(uid:author_id)
			errors.add(:author_id, "は認証されたアカウントではありません")
		end
	end
end
