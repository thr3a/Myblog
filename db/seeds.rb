# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create(name: "その他")
Category.create(name: "Ruby")
Category.create(name: "Javascript")
Category.create(name: "ねこ")


Article.create(title: "no title", content: "hello world!", category_id: 1, author: "1179190262")
