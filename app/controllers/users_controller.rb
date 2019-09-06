class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  skip_before_action :logged_in_user, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def show
    @feed_items = @user.feed.paginate(page: params[:page], per_page: 10)
    if current_user.following?(@user)
      @user_unfollow = current_user.active_relationship_user.find_by(followed_id: @user.id)
    else
      @user_follow = current_user.active_relationship_user.build
    end
  end

  def index
    @user_search = User.search_user(params[:search])
    @users = @user_search.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.xlsx{
        filename = "User_#{Time.now}"
        response.headers["Content-Disposition"] = "attachment; filename=#{filename}"
      }
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] =t(:create_complete)
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t(:update_complete)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t(:delete_complete)
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :content, :role, :password, :password_confirmation)
  end

  def correct_user
    redirect_to root_path unless current_user?(@user) || current_user.admin?
  end

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:info] = t(:no_exits)
    redirect_to users_path
  end
end
