class VideosController < ApplicationController
  before_filter :require_user

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def new
  end

  def create

  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @searched_videos = Video.search_by_title(params[:search_term])
    #redirect_to search_video_path
  end

  private

  def video_params

  end
end