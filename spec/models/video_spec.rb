require 'spec_helper'

describe Video do 
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should have_many(:reviews).order("created_at DESC")}

  describe "search_by_title" do
  	it "returns an empty array if there is no match" do
  		futurama = Video.create(title: "Futurama", description: "Space cartoon.")
  		back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("hello")).to eq([])
    end
  	it "returns an array of one video for an exact match" do
      dragon_ball = Fabricate(:video, title: "Dragon Ball")
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("Dragon Ball")).to eq([dragon_ball])
    end
  	it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "Futurama", description: "Space cartoon.")
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("Ba")).to eq([back_to_future])
    end
  	it "returns an array of all matches ordered by created_at" do
      video_1 = Fabricate(:video, title: "Dragon Ball", created_at: 2.days.ago)
      video_2 = Fabricate(:video, title: "Dragon Ball Z", created_at: 1.day.ago)
      video_3 = Fabricate(:video, title: "Dragon Ball Super")
      expect(Video.search_by_title("Dragon")).to eq([video_3, video_2, video_1])
    end
    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: "Futurama", description: "Space cartoon.", created_at: 1.day.ago )
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end