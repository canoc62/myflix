require 'spec_helper'


describe QueueItemsController do

  describe "GET index" do

    it "sets @queue_items to the queue items of the logged in user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item_1 = Fabricate(:queue_item, user: user)
      queue_item_2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item_1, queue_item_2])
    end

    it "redirects to sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before { session[:user_id] = user.id }

      it "redirects to my queue page" do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "creates a queue item" do
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "creates the queue item that is associated with the video" do
        post :create, video_id: video.id
        expect(video.queue_items.count).to eq(1)
      end
      it "creates the queue item that is associated with the user" do
        post :create, video_id: video.id
        expect(user.queue_items.count).to eq(1)
      end
      it "puts the video as the last one in the queue" do
        video_2 = Fabricate(:video)
        Fabricate(:queue_item, user: user, video: video)
        post :create, video_id: video_2.id
        queue_item_2 = QueueItem.where(user_id: user.id, video_id: video_2.id).first
        expect(queue_item_2.position).to eq(2)
      end
      it "does not add the video to the queue if the video is already in the queue" do
        Fabricate(:queue_item, user: user, video: video)
        post :create, video_id: video.id
        expect(video.queue_items.count).to eq(1)
      end
    end

    context "with unauthenticated users" do

      it "redirects to the sign in page for unauthenticated users" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "DELETE destroy" do

    context "with authenticated users" do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      it "redirects to my_queue page" do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
      it "deletes the queue item" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id
        expect(user.queue_items.count).to eq(0)
      end
      it "does not delete that queue item if the queue item is not in the current user's queue" do
        user_2 = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: user_2)
        delete :destroy, id: queue_item.id
        expect(user_2.queue_items.count).to eq(1)
      end
    end

    context "with unauthenticated users" do

      it "redirects to the sign in page for unauthenticated users" do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end