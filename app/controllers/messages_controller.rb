class MessagesController < ApplicationController
    before_action :get_instance
  def index

  end

    def get_instance
    @group = Message.new
    @groups = Message.new
    @message = Message.new
    @messages = Message.new
  end

end
