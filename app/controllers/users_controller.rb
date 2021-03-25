class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])

    @share_video = YoutubeVideo.where(video_id: params[:share_video_unique_id]).first
  end

  def index
    not_like_reactions = Reaction.where.not(status: 'like').where( from_user_id: current_user.id)
    not_like_reaction_to_user_ids = Reaction.where.not(status: 'like').where(from_user_id: current_user.id).map(&:to_user_id)

    if Reaction.where(to_user_id: current_user.id).blank?
      @users = User.where.not(id: current_user.id, role: "dammy")
    else
      @users = User.find(not_like_reaction_to_user_ids).shuffle
      @users.reject! do |user| 
        user.role == "guest" || user.role == "dammy"
      end
      
    end

    @user = User.find(current_user.id)
  end
end
