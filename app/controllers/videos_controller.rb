class VideosController < ApplicationController

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

  private

  def video_params

  end
end