class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :set_user,       only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if(@user.save)
      log_in @user
      flash[:success] = "Create account complete!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if(@user.update_attributes(user_params))
      flash[:success] = "Update user complete!"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User delete!"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :content, :level, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
