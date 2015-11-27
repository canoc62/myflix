require 'spec_helper'

describe VideosController do
  describe "GET show" do

    context "with authenticated users" do 
      before { session[:user_id] = Fabricate(:user).id }
      let(:video) { Fabricate(:video) }

    	it "sets @video instance variable" do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      it "sets @reviews instance variable for authenticated users" do
        review_1 = Fabricate(:review, video: video)
        review_2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review_1, review_2]) 
      end
    end

    it_behaves_like "requires sign in" do
      video = Fabricate(:video)
      let(:action) { get :show, id: video.id }
    end
  end

  describe "POST search" do
    it "sets @results instance variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(assigns(:results)).to include(futurama)
    end

    it_behaves_like "requires sign in" do
      futurama = Fabricate(:video, title: 'Futurama')
      let(:action) { post :search, search_term: 'rama' }
    end
  end
end