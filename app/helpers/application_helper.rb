module ApplicationHelper
	@@markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
		autolink: true, #http, https, ftp等の自動リンク
		space_after_headers: true, #「#」のあとに空白を必要とするか
		no_intra_emphasis: true, # foo_bar_bazをemタグにしない
		fenced_code_blocks: true, # 「```」によるコードブロック
		tables: true, # PHP-Markdownスタイルの表を有効化
		strikethrough: true # ~~」によるdelタグの生成

	def markdown(text)
		@@markdown.render(text).html_safe
	end
end
