class GroupsController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.new
    @groups = current_user.groups
    @friends = current_user.followings
    @friend_group = current_user.groups.where(onetoone: "1")
    friendgroups = Group.where(user: { id: current_user.id})
    #friend_groupはonetooneが１のレコードたち
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
    if  params[:group][:onetoone]
      group_friend_permit_params
      @group = Group.new(group_friend_permit_params)
      binding.pry
    else
      group_permit_params
      @group = Group.new(group_permit_params)
    end
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
  def group_friend_permit_params
    params.require(:group).permit(:name,:onetoone, user_ids: [])
  end

  def group_permit_params
    params.require(:group).permit(:name, user_ids: [])
  end


end
