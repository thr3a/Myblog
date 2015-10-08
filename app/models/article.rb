class Article < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 30 }
	validates :content, presence: true
end
