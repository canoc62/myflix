require 'spec_helper'

describe VideosController do
  describe "GET show" do

    context "with authenticated users" do 
      before do
        #user = User.create(email: 'user@example.com', password: 'password', full_name: "Example" )
        session[:user_id] = Fabricate(:user).id #user.id
      end

    	it "sets @video instance variable" do
        video = Fabricate(:video)#Video.create(title: "Monk", description: "Monk is cool.")
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
    end

    it "sets @reviews instance variabe for authenticated users" do
      session[:user_id] = Fabricate(:user).id #user.id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      assigns(:reviews).should =~ [review1, review2]
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