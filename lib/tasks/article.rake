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
	end

	desc "insert dummy data"
	task insert: :environment do
		Article.destroy_all
		Article.record_timestamps = false
		100.times do |i|
			from = Date.parse("2010/01/01")
			to = Date.parse("2015/01/01")
			s = Random.rand(from .. to)
			Article.create(title: "#{i} title", content: SecureRandom.base64(100), category_id: Random.rand(1..4), author_id: "1179190262", created_at: s, updated_at: s)
		end
		Article.record_timestamps = true
	end

  desc "insert dummy data"
  task qiita: :environment do
		Article.destroy_all
		require 'open-uri'
		res = open "http://qiita.com/api/v2/items"
		posts = JSON.parse(res.read).map { |p| [p["title"], p["body"].encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: '').encode('UTF-8')] }
		posts.each do |post|
			Article.create(title: post[0], content: post[1], category_id: 1, author_id: "1179190262")
			sleep 1
		end
	end
end
