class CategoriesController < ApplicationController

	# POST /categories
	def create
		@category = Category.new(category_params)
		@category.save
	end

	# DELETE /categories/:id
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
	end

	def index
		redirect_to root_path
	end

	private
		def category_params
			params.require(:category).permit(:name)
		end
end
