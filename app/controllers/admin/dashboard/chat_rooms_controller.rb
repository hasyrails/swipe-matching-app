class Admin::Dashboard::ChatRoomsController < ApplicationController
  layout 'admin/dashboard/application.html.erb'

  before_action :admin_user
  before_action :set_chat_room_model_name
  before_action :set_column_names_of_chat_room_model

  def index
    @chat_rooms = ChatRoom.page(params[:page]).per(5)
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  def edit
    @chat_room = ChatRoom.find(params[:id])
  end

  def update
    @chat_room = ChatRoom.find(params[:id])
    @chat_room.update(chat_room_params)
  end


  
  def destroy
    @chat_room = ChatRoom.find(params[:id])
    @chat_room.destroy
    redirect_to admin_dashboard_chat_rooms_path
  end



  private
  
  def set_chat_room_model_name
    @model_name = ChatRoom.model_name.name
  end
  
  def set_column_names_of_chat_room_model
    @columns = ActiveRecord::Base.connection.columns(:chat_rooms)
    
    column_names = []
    @columns.each do |column|
      column_names << column.name
    end
    @column_names = column_names

  end
  
  def chat_room_params
    params.require(:chat_room).permit(@column_names)
  end

  def admin_user
    redirect_to(root_path) if  current_user.nil? || !current_user.admin?
  end

end
