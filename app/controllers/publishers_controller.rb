class PublishersController < ApplicationController
  before_action :set_publisher,   only: [:show, :edit, :update]
  before_action :admin_user,      only: [:create, :edit, :update, :destroy]
  before_action :before_destroy,  only: :destroy

  def new
    @publisher = Publisher.new
  end

  def show
    @books = @publisher.books.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def index
    @publishers = Publisher.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      flash[:success] = t(:create_complete)
      redirect_to @publisher
    else
      render :new
    end
  end

  def update
    if @publisher.update_attributes(publisher_params)
      flash[:success] = t(:update_complete)
      redirect_to publishers_path
    else
      render :edit
    end
  end

  def destroy
    Publisher.find(params[:id]).destroy
    flash[:success] = t(:delete_complete)
    redirect_to publishers_path
  end

  private
  def publisher_params
    params.require(:publisher).permit(:name, :address, :content)
  end

  def set_publisher
    @publisher = Publisher.find_by(id: params[:id])
    return if @publisher
    flash[:info] = t(:no_exits)
    redirect_to publishers_path 
  end

  def before_destroy
    @publisher = Publisher.find(params[:id])
    @publisher.update_book_publisher
  end
end
