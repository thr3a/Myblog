class ArticlesController < ApplicationController

	before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]


	# GET /
	def index
		@articles = Article.recent.fetchpage(params[:page])
	end

	# GET /articles/new
	def new
		@article = Article.new
	end

	# POST /articles
	def create
		@article = Article.new(article_params)
		# 今までにないカテゴリが付与されていた場合はカテゴリも新規作成
		if params[:new_category].present?
			@article.category_id = Category.find_or_create_by(name: params[:new_category]).id
		end
		@article.author = session[:user]["nickname"]
		if @article.save
			redirect_to article_path(@article.id), notice: "投稿に成功しました"
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
		# 今までにないカテゴリが付与されていた場合はカテゴリも新規作成
		if params[:new_category].present?
			# Article.last.update(category_id: Category.find_or_create_by(name: "しめじ").id)
			p @article.update(category_id: Category.find_or_create_by(name: params[:new_category]).id)
		end
		if @article.update(article_params)
			redirect_to article_path(@article.id), notice: "編集に成功しました"
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
		p params[:id]
		@articles = Category.find_by(name: params[:name]).articles.recent.fetchpage(params[:page])
		render :index
	end

	# GET /archive/:year/:month
	def archive
		if params[:month]
			@articles = Article.by_month(params[:month], year: params[:year]).recent.fetchpage(params[:page])
		else
			@articles = Article.by_year(params[:year]).recent.fetchpage(params[:page])
		end
		render :index
	end

	private
		def article_params
			params.require(:article).permit(:title, :content, :category_id, :new_category)
		end

		# セッションを元にTwitterログイン済みかどうか
		def authenticate_user
			permit_users = ["1179190262"]
			if session[:user].nil?
				redirect_to root_path, alert: '先にログインをしてください'
			else
				if(permit_users.include?(session[:user]["uid"]))
					return true
				else
					redirect_to root_path, alert: 'このアカウントは承認されていません'+ session[:user]["uid"]
				end
			end
		end
end
