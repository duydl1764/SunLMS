class AuthorsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy, :index]
  before_action :admin_user,     only: [:create, :edit, :update, :destroy]
  before_action :before_destroy,  only: :destroy

  def new
  	@author = Author.new
  end

  def show
  	@author = Author.find(params[:id])
    @books = @author.books.paginate(page: params[:page])
  end

  def index
    @authors = Author.paginate(page: params[:page])
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
  	@author = Author.new(author_params)
  	if(@author.save)
  		flash[:success] = "Create author complete!"
  		redirect_to authors_path
  	else
  		render 'new'
  	end
  end

  def update
    @author = Author.find(params[:id])
    if(@author.update_attributes(author_params))
      flash[:success] = "Update author complete!"
      redirect_to authors_path
    else
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = "Delete author complete!"
    redirect_to authors_path
  end

  private

  	def author_params
  		params.require(:author).permit(:name, :nickname, :content)
  	end

    def before_destroy
      @author = Author.find(params[:id])
      @author.books.each do |book|
        book.update_before_destroy_author
      end
    end

end
