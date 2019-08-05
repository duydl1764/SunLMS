class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:create, :edit, :update, :destroy]
  before_action :before_destroy, only: :destroy

  def new
  	@category = Category.new
  end

  def show
  	@category = Category.find(params[:id])
    @books = @category.books.paginate(page: params[:page])
  end

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
  	@category = Category.new(category_params)
  	if(@category.save)
  		flash[:success] = "Create category complete!"
  		redirect_to categories_path
  	else
  		render 'new'
  	end
  end

  def update
    @category = Category.find(params[:id])
    if(@category.update_attributes(category_params))
      flash[:success] = "Update category complete!"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Delete category complete!"
    redirect_to categories_path
  end

  private

  	def category_params
  		params.require(:category).permit(:name, :content)
  	end

    def before_destroy
      @category = Category.find(params[:id])
      @category.books.each do |book|
        book.update_before_destroy_category
      end
    end

end
