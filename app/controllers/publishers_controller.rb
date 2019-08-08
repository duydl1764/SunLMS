class PublishersController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:create, :edit, :update, :destroy]
  before_action :set_category,   only: [:show, :edit, :update]
  before_action :before_destroy, only: :destroy

  def new
    @publisher = Publisher.new
  end

  def show
    @books = @publisher.books.paginate(page: params[:page])
  end

  def edit
  end

  def index
    @publishers = Publisher.paginate(page: params[:page])
  end
  
  def create
    @publisher = Publisher.new(publisher_params)
    if(@publisher.save)
      flash[:success] = "Create publisher complete"
      redirect_to publishers_path
    else
      render :new
    end
  end

  def update
    if(@publisher.update_attributes(publisher_params))
      flash[:success] = "Update publisher complete!"
      redirect_to publishers_path
    else
      render :edit
    end
  end

  def destroy
    Publisher.find(params[:id]).destroy
    flash[:success] = "Publisher delete!"
    redirect_to publishers_path
  end

  private
  def publisher_params
    params.require(:publisher).permit(:name, :address, :content)
  end

  def before_destroy
    @publisher = Publisher.find(params[:id])
    @publisher.books.each do |book|
      book.update_before_destroy_publisher
    end
  end

  def set_category
    @publisher = Publisher.find(params[:id])    
  end
end
