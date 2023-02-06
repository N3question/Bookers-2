class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @book = Book.new
    @user = User.find(params[:id]) #ユーザの番号の情報が入る
    @books = Book.where(user_id: @user.id) #whereメゾットで欲しい情報を取得。@userで定義した内容を代入する。
  end
  
  def index
    @book = Book.new
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      # flash[:alert] = "You have not updated user successfully."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
end