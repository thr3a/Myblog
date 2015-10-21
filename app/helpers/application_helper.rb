module ApplicationHelper
	class HTMLwithCoderay < Redcarpet::Render::HTML
		def block_code(code, language)
			language ||= 'md'
			CodeRay.scan(code, language.to_sym).div(line_numbers: :table)
		end
	end
	def markdown(text)
		redcarpet_options = {
			autolink: true, #http, https, ftp等の自動リンク
			space_after_headers: true, #「#」のあとに空白を必要とするか
			no_intra_emphasis: true, # foo_bar_bazをemタグにしない
			fenced_code_blocks: true, # 「```」によるコードブロック
			tables: true, # PHP-Markdownスタイルの表を有効化
			strikethrough: true, # ~~」によるdelタグの生成
		}
		html_render = HTMLwithCoderay.new(
			filter_html: true,
			hard_wrap: true,
			link_attributes: { rel: 'nofollow', target: "_blank" }
		)
		markdown = Redcarpet::Markdown.new(html_render, redcarpet_options)
		markdown.render(text)
	end
end
