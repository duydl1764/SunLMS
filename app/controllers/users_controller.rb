class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def show
    # @comments = @user.comments.paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] =t(:text_flash_create)
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t(:text_flash_update)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t(:text_flash_delete)
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:info] = t(:text_flash_info)
    redirect_to users_path
  end
end
