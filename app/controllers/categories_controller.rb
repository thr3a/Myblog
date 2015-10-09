class CategoriesController < ApplicationController

	# POST /categories
	def create
		@category = Category.new(category_params)
		if @category.save
			"ok"
		else
			"ng"
		end
	end

	# DELETE /categories/:id
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		"ok"
	end
end
