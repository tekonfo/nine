class UsersController < ApplicationController


  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    user.update(params_permit)
    redirect_to controller: :groups, action: :index
  end


  private
    def params_permit
      params.require(:user).permit(:name,:email)
    end
end
