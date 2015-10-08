class ArticlesController < ApplicationController

	# GET /
	def index
		@articles = Article.all
	end

	# GET /articles/new
	def new
		@article = Article.new
	end

	# POST /articles
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to root_path, notice: "投稿に成功しました"
		else
			render :new
		end
	end

	def show
		@article = Article.find(params[:id])
	end
	private
		def article_params
			params.require(:article).permit(:title, :content)
		end
end
