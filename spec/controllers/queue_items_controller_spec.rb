require 'spec_helper'


describe QueueItemsController do

  describe "GET index" do

    it "sets @queue_items to the queue items of the logged in user" do
      user = Fabricate(:user)
      set_current_user(user)
      queue_item_1 = Fabricate(:queue_item, user: user)
      queue_item_2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item_1, queue_item_2])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before { set_current_user(user) }

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

    it_behaves_like "requires sign in" do
      let(:video) { Fabricate(:video) }
      let(:action) { post :create, video_id: video.id }
    end
  end
    

  describe "DELETE destroy" do

    context "with authenticated users" do
      let(:user) { Fabricate(:user) }
      before { set_current_user(user) }

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
      it "normalizes the position numbers" do
        queue_item_1 = Fabricate(:queue_item, user: user, position: 1)
        queue_item_2 = Fabricate(:queue_item, user: user, position: 2)
        delete :destroy, id: queue_item_1.id
        expect(queue_item_2.reload.position).to eq(1)
      end
    end

    it_behaves_like "requires sign in" do
      let(:queue_item) { Fabricate(:queue_item) }
      let(:action) { delete :destroy, id: queue_item.id}
    end
  end
   

  describe "POST update_queue" do

    context "input validation" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:video_2) { Fabricate(:video) }
      before { set_current_user(user) } 
      let(:queue_item_1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
      let(:queue_item_2) { Fabricate(:queue_item, user: user, video: video_2, position: 2) }

      context "with valid inputs" do
        
        it "redirects to the my queue page" do
          post :update_queue, queue_items: [{id: queue_item_1.id, position: 2}, {id: queue_item_2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end

        it "reorders the queue items" do
          post :update_queue, queue_items: [{id: queue_item_1.id, position: 2}, {id: queue_item_2.id, position: 1}]
          expect(user.queue_items).to eq([queue_item_2, queue_item_1])
        end

        it "normalizes the position numbers" do
          post :update_queue, queue_items: [{id: queue_item_1.id, position: 3}, {id: queue_item_2.id, position: 2}]
          expect(user.queue_items.map(&:position)).to eq([1,2])
        end
      end

      context "with invalid inputs" do
        it "redirects to the my_queue page" do
          post :update_queue, queue_items: [{id: queue_item_1.id, position: 3.1}, {id: queue_item_2.id, position: 2.2}]
          expect(response).to redirect_to my_queue_path
        end
        it "sets the flash error message" do
          post :update_queue, queue_items: [{id: queue_item_1.id, position: 3}, {id: queue_item_2.id, position: 2.2}]
          expect(flash[:error]).not_to be_blank
        end
        it "does not change the queue items" do
          post :update_queue, queue_items: [{id: queue_item_1.id, position: 3}, {id: queue_item_2.id, position: 2.2}]
          expect(user.queue_items).not_to eq([queue_item_2, queue_item_1])
        end
      end
    end
      
    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 1, position: 3}, {id: 2, position: 2}] }
    end
    

    context "with queue items that do not belong to the current user" do
      it "does not change the order of another user's queue items" do
        user = Fabricate(:user)
        set_current_user(user)
        user_2 = Fabricate(:user)
        queue_item_1 = Fabricate(:queue_item, user: user_2, position: 1)
        queue_item_2 = Fabricate(:queue_item, user: user_2, position: 2)
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 3}, {id: queue_item_2.id, position: 2}]
        expect(user_2.queue_items).to eq([queue_item_1, queue_item_2])
      end
    end
  end
end