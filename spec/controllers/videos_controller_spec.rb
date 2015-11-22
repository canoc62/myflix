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

      it "sets @reviews instance variabe for authenticated users" do
        review_1 = Fabricate(:review, video: video)
        review_2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review_1, review_2]) 
      end
    end

    context "with unauthenticated users" do
      it "redirects the user to the sign in page" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST search" do
    it "sets @results instance variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it "redirects to sign in page for unauthenticated users" do
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
end