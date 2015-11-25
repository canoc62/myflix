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