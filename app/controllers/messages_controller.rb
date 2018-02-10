class MessagesController < ApplicationController
  before_action :authenticate_user!,only: :index
  before_action :get_instance
  def index
      respond_to do |format|
        format.html
        format.json
      end
  end
  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "メッセージの作成に成功しました。"
      respond_to do |format|
        format.html { redirect_to action: :index  }
        format.json
      end

    else
      flash[:alert] = "メッセージを送信してください"
      render  action: :index
    end

  end

  private

  def get_instance
    @current_user = current_user
    @groups = current_user.groups
    @friends = current_user.followings
    @groups_friend = current_user.groups.where(onetoone: "1")
    @friend_group = User.find(1).groups.where(onetoone: "1")
    @end = []
    @friend_group.each do |friend|
      @groups_friend.each do |group|
        if friend.id == group.id
            @end = group
            break
        end
      end
    end
    @group = Group.find(params[:group_id])
    @message = Message.new
    @messages = @group.messages
  end

  def message_params
    params.require(:message).permit(:text, :image).merge(group_id: params[:group_id].to_i,user_id: current_user.id)
  end
end
