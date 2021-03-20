class Admin::Dashboard::YoutubeVideosController < ApplicationController
  layout 'admin/dashboard/application.html.erb'

  before_action :admin_user
  before_action :set_youtube_video_model_name
  before_action :set_column_names_of_youtube_video_model

  def index
    @youtube_videos = YoutubeVideo.page(params[:page]).per(5)
  end

  def show
    @youtube_video = YoutubeVideo.find(params[:id])
  end

  def edit
    @youtube_video = YoutubeVideo.find(params[:id])
  end

  def update
    @youtube_video = YoutubeVideo.find(params[:id])
    @youtube_video.update(youtube_video_params)
  end


  
  def destroy
    @youtube_video = YoutubeVideo.find(params[:id])
    @youtube_video.destroy
    redirect_to admin_dashboard_youtube_videos_path
  end



  private
  
  def set_youtube_video_model_name
    @model_name = YoutubeVideo.model_name.name
  end
  
  def set_column_names_of_youtube_video_model
    @columns = ActiveRecord::Base.connection.columns(:youtube_videos)
    
    column_names = []
    @columns.each do |column|
      column_names << column.name
    end
    @column_names = column_names

  end
  
  def youtube_video_params
    params.require(:youtube_video).permit(@column_names)
  end

  def admin_user
    redirect_to(root_path) if  current_user.nil? || !current_user.admin?
  end

end
