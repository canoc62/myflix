class ReviewsController < ApplicationController
  before_filter :require_user
	def create
    #binding.pry
    @video = Video.find(params[:video_id])
    review = Review.new(review_params)#@review = Review.new(review_params)
    #review = @video.reviews.build(review_params.merge!(user: current_user))
    @video.reviews << review
    current_user.reviews << review

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