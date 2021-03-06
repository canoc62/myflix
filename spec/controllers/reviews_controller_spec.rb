require 'spec_helper'

describe ReviewsController do 

  describe "POST create" do
    let(:video) {Fabricate(:video)}

    context "with authenticated users" do
      let(:user) { Fabricate(:user) }
      before { set_current_user(user) }

      context "with valid inputs" do
        before do
          review = Fabricate.attributes_for(:review)
          post :create, review: review, video_id: video.id
        end
        it "redirects to video show page if submission is successful" do
          expect(response).to redirect_to video
        end
        it "creates the review" do
          expect(Review.count).to eq(1)
        end
        it "creates a review associated with the video" do
          expect(video.reviews.count).to eq(1)
        end
        it "creates a review associated with the signed in user" do 
          expect(user.reviews.count).to eq(1)
        end
      end
    

      context "with invalid inputs" do
        it "does not create a review without rating or content" do
          post :create, review: { rating: 4 }, video_id: video.id
          expect(Review.count).to eq(0)
        end
        it "renders the video show template" do
          post :create, review: { rating: 4 }, video_id: video.id
          expect(response).to render_template 'videos/show'
        end
        it "shows error message if there submission is unsuccessful" do
          post :create, review: { rating: 4 }, video_id: video.id
          expect(flash[:error]).not_to be_blank
        end
        it "sets @video instance variable" do
          post :create, review: { rating: 4 }, video_id: video.id
          expect(assigns[:video]).to eq(video)
        end
        it "sets @review instance variable" do
          review = Fabricate(:review, video: video)
          post :create, review: { rating: 4 }, video_id: video.id
          expect(assigns[:reviews]).to match_array([review])
        end
      end
    end
  
    it_behaves_like "requires sign in" do
      review = Fabricate.attributes_for(:review)
      let(:action) { post :create, review: review, video_id: video.id }
    end
  end
end