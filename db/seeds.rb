# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ダミーアカウント追加
Author.create(uid:"1179190262", scname:"amenekey", image:"https://pbs.twimg.com/profile_images/664096442835820544/edyJrRSj.jpg")

# ダミーカテゴリ追加
Category.create(name: "その他")
Category.create(name: "Ruby")
Category.create(name: "Javascript")
Category.create(name: "ねこ")
#
# # ダミー記事追加
Article.create(title: "これはあなたです！", content: "なわけないだろ", category_id: 1, author_id: "1179190262")
