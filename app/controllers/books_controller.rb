class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:create, :edit, :update, :destroy]
  before_action :set_book,       only: [:show, :edit, :update]

  def new
    @book = Book.new
  end

  def show
  end

  def index
      @books = Book.paginate(page: params[:page])
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if(@book.save)
      flash[:success] = "Create book complete!"
      redirect_to books_path
    else
      render :new
    end
  end

  def update
    if(@book.update_attributes(book_params))
      flash[:success] = "Update book complete!"
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Delete book complete!"
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:name, :status, :content, :pages, :number_of, :author_id, :category_id, :publisher_id )
  end

  def set_book
    @book = Book.find(params[:id]) 
  end
end
