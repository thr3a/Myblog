class Article < ActiveRecord::Base

	belongs_to :category, foreign_key: "category_id"

	belongs_to :author, foreign_key: "author_id", primary_key: "uid"

	validates :title, presence: true, length: { maximum: 30 }
	validates :content, presence: true
	validates :category, presence: true
	validates :author, presence: true
	# validate :author, :authenticate_user

	scope :recent, -> { order(created_at: :desc) }
	scope :fetchpage, ->(page) { paginate(page: page, per_page: 5)}

	private
	def authenticate_user
		permit_users = ["1179190262"]
		if !permit_users.include?(author)
			errors.add(:author, "が認証されたアカウントではありません")
		end
	end
end
