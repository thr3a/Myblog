# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ダミーアカウント追加
Author.create(uid:"1179190262", scname:"amenekey", image:"")

# ダミーカテゴリ追加
Category.create(name: "その他")

# ダミー記事追加
Article.create(title: "こんにちは！", content: "はじめまして", category_id: Category.first.id, author_id: Author.first.uid)
