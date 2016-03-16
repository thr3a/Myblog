class ArticlesController < ApplicationController

	before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy, :admin]


	def new
	   @post = Post.new
	end

	# GET /
	def index
		@articles = Article.recent.page params[:page]
	end

	# GET /articles/new
	def new
		@article = Article.new
		@title = "新規作成中"
	end

	# POST /articles
	def create
		@article = Article.new(article_params)
		# 今までにないカテゴリが付与されていた場合はカテゴリも新規作成
		if params[:new_category].present?
			@article.category_id = Category.find_or_create_by(name: params[:new_category]).id
		end
		@article.author_id = session[:user]["uid"]
		if @article.save
			redirect_to article_path(@article.id), notice: "投稿に成功しました"
		else
			flash.now[:alert] = @article.errors.full_messages
			render :new
		end
	end

	# GET /:id
	def show
		@article = Article.find(params[:id])
		@title = @article.title
	end

	# GET /:id/edit
	def edit
		@article = Article.find(params[:id])
		@title = "編集中:" + @article.title
	end

	# PATCH/PUT /articles/:id
	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			@article.update(category_id: Category.find_or_create_by(name: params[:new_category]).id) if(params[:new_category].present?)
			redirect_to article_path(@article.id), notice: "編集に成功しました"
		else
			flash.now[:alert] = @article.errors.full_messages
			render :edit
		end
	end

	# DELETE /articles/:id
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to :back, notice: '削除に成功しました'
	end

	# GET /category/:id
	def category
		if(category = Category.find_by(name: params[:name]))
			@title = "#{category.name}の記事一覧"
			@articles = category.articles.recent.page params[:page]
			render :index
		else
			redirect_to root_path
		end
	end

	# GET /article/feed
	def feed
		@articles = Article.recent.limit(20)
		respond_to do |format|
			format.xml { render :layout => false }
		end
	end

	# GET /archive/:year/:month
	def archive
		if params[:month].present?
			@articles = Article.by_month(params[:month], year: params[:year]).recent.page params[:page]
			@title = "#{params[:year]}年#{params[:month]}月の記事一覧"
		else
			@articles = Article.by_year(params[:year]).recent.page params[:page]
			@title = "#{params[:year]}年の記事一覧"
		end
		render :index
	end

	# GET /admin
	def admin
		@articles = Article.where(author_id: session[:user]["uid"]).recent.page params[:page]
		render :admin
	end

	private
		def article_params
			params.require(:article).permit(:title, :content, :category_id, :new_category)
		end

		# セッションを元にTwitterログイン済みかどうか
		def authenticate_user
			if session[:user].nil?
				redirect_to root_path, alert: '先にログインをしてください'
			elsif !Author.exists?(uid:session[:user]["uid"])
				redirect_to root_path, alert: 'このアカウントは承認されていません'+session[:user]["uid"]
			end
		end
end
