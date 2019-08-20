class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update]
  before_action :admin_user, only: [:create, :edit, :update, :destroy]
  before_action :before_destroy, only: :destroy

  def new
    @author = Author.new
  end

  def show
    @books = @author.books.paginate(page: params[:page], per_page: 5)
  end

  def index
    @authors = Author.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:success] = t(:create_complete)
      redirect_to authors_path
    else
      render :new
    end
  end

  def update
    if @author.update_attributes(author_params)
      flash[:success] = t(:update_complete)
      redirect_to authors_path
    else
      render :edit
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = t(:delete_complete)
    redirect_to authors_path
  end

  private
  def author_params
    params.require(:author).permit(:name, :nickname, :content)
  end

  def set_author
    @author = Author.find_by(id: params[:id])
    return if @author
    flash[:info] = t(:no_exits)
    redirect_to authors_path
  end

  def before_destroy
    @author = Author.find(params[:id])
    @author.update_book_author
  end
end
