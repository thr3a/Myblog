class ArticlesController < ApplicationController

	# GET /
	def index
		@category = Category.all
		@articles = Article.newest.paginate(page: params[:page], per_page: 5)
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

	# GET /:id
	def show
		@article = Article.find(params[:id])
	end

	# GET /:id/edit
	def edit
		@article = Article.find(params[:id])
	end

	# PATCH/PUT /articles/:id
	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to root_path, notice: "編集に成功しました"
		else
			render :edit
		end
	end

	# DELETE /articles/:id
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to root_path, notice: '削除に成功しました'
	end

	def testtest
		100.times do |i|
			Article.new(title: "#{i} title", content: SecureRandom.base64(1000)).save
		end
		redirect_to root_path, notice: '挿入に成功しました'
	end
	private
		def article_params
			params.require(:article).permit(:title, :content, :category_id)
		end
end
