namespace :article do
	desc "delete dummy data"
	task delete: :environment do
		Article.delete_all
	end

	desc "delete dummy data"
	task hoge: :environment do
		Article.destroy_all
		Category.destroy_all
		Author.destroy_all
		ArticleAttachment.destroy_all
	end

	desc "insert dummy data"
	task insert: :environment do
		Article.record_timestamps = false
		100.times do |i|
			from = Date.parse("2010/01/01")
			to = Date.parse("2015/01/01")
			s = Random.rand(from .. to)
			Article.create(title: "#{i} title", content: SecureRandom.base64(100), category_id: Random.rand(1..4), author: "1179190262", created_at: s, updated_at: s)
		end
		Article.record_timestamps = true
end

end
