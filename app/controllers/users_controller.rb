class UsersController < ApplicationController
  before_action :authorize_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: t(:user_saved)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update(user_params)
      redirect_to users_path, notice: t(:user_saved)
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by_id(params[:id])

    user.destroy

    redirect_to users_path, notice: t(:user_deleted)
  end

  private

  def user_params
    new_params = params.require(:user).permit(:username, :email, :language, :role, :password)

    new_params[:role] = new_params[:role].to_i

    new_params
  end
end
