require 'spec_helper'

describe QueueItem do

	it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer}

  describe "#video_title" do
    it "should return the associated video's title" do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe "#rating" do
    it "should return the associated video's rating" do
      user = Fabricate(:user)
      video = Fabricate(:video, title: 'Monk')
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end

    it "should return nil when the review is not present" do
      user = Fabricate(:user)
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to be_nil
    end
  end

  describe "#rating=" do
    context "with present reviews" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:review) {Fabricate(:review, rating: 5, user: user, video: video) }
      let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

      it "changes the rating of the video" do
        queue_item.rating = 4
        expect(video.reviews.first.rating).to eq(4)
      end
      it "can clear the rating of the video" do
        queue_item.rating = nil
        expect(video.reviews.first.rating).to be_nil
      end
    end

    it "creates a new review with rating if the review of the video does not yet exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 5
      expect(video.reviews.first.rating).to eq(5)
    end
  end
  

  describe "#category_name" do
    it "should return the associated video's category name" do
      category = Fabricate(:category, name: 'Queue Category')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq('Queue Category')
    end
  end

  describe "#category" do
    it "should return the associated video's category" do
      category = Fabricate(:category, name: 'Queue Category')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end

end