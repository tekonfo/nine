class UsersController < ApplicationController


  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    user.update(params_permit)
    redirect_to controller: :groups, action: :index
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def show
    @user = User.find(params[:id])
  end


  private
    def params_permit
      params.require(:user).permit(:name,:email)
    end
end
