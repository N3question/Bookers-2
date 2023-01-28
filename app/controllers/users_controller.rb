class UsersController < ApplicationController
  
  def show
    @user = User.find(current_user.id)
  end
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      flash[:alert] = "You have not updated user successfully."
      render edit_user_path(current_user.id)
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
