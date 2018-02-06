class GroupsController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.new
    @groups = current_user.groups
    @friends = current_user.followings
  end

  def newfriend
    @user_ids = []
    @group = Group.new
    @friend = []
    @friend << User.find(params[:friend_id].to_i)
    @friend << current_user
    @user_ids << current_user.id
    @user_ids << @friend[0].id
  end

  def new
    @group = Group.new
    @users = User.all
  end


  def create
    binding.pry
    @group = Group.new(group_permit_params)
    if  @group.save
      flash[:notice] = "グループの作成に成功しました。"
      redirect_to  action: :index
    else
      @user = User.all
      flash[:alert] = "グループの作成に失敗しました。"
      render action: :new
    end
  end


  def edit
    @group = Group.find(params[:id])
    @user = User.all
  end

  def update
    @group = Group.find(params[:id])
    if  @group.update(group_permit_params)
      flash[:notice] = "グループの編集に成功しました。"
      redirect_to  action: :index
    else
      @user = User.all
      flash[:notice] = "グループの編集に失敗しました。"
      render action: :edit
    end
  end


  private

  def group_permit_params
    params.require(:group).permit(:name, user_ids: [])
  end


end
