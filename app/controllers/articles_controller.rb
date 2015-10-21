class ArticlesController < ApplicationController

	# GET /
	def index
		@articles = Article.recent.paginate(page: params[:page], per_page: 5)
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

	# GET /category/:id
	def category
		@articles = Article.where( category: params[:id]).recent.paginate(page: params[:page], per_page: 5)
		render :index
	end
	# GET /category/:id
	def category
		@articles = Article.where( category: params[:id]).recent.paginate(page: params[:page], per_page: 5)
		render :index
	end

	# GET /archive/:year/:month
	def archive
		if params[:month]
			@articles = Article.by_month(params[:month], year: params[:year]).recent.paginate(page: params[:page], per_page: 5)
		else
			@articles = Article.by_year(params[:year]).recent.paginate(page: params[:page], per_page: 5)
		end
		render :index
	end

	def testtest
		Article.record_timestamps = false
		100.times do |i|
			from = Date.parse("2010/01/23")
			to = Date.parse("2015/04/12")
			s = Random.rand(s1 .. s2)
			Article.new(title: "#{i} title", content: SecureRandom.base64(100), category_id: 1, created_at: s, updated_at: s).save
		end
		Article.record_timestamps = true
		redirect_to root_path, notice: '挿入に成功しました'
	end
	private
		def article_params
			params.require(:article).permit(:title, :content, :category_id)
		end
end
