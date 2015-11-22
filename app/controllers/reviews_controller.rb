class ReviewsController < ApplicationController
  before_filter :require_user
	def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params.merge!(user: current_user))

    if review.save
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews.reload
      flash[:error] = "Review must include a rating and the content can't be blank."
      render 'videos/show'
    end
  end

  private 

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end