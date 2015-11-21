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
      futurama = Video.create(title: "Futurama", description: "Space cartoon.")
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end
  	it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "Futurama", description: "Space cartoon.")
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("Ba")).to eq([back_to_future])
    end
  	it "returns an array of all matches ordered by created_at" do
      futurama = Video.create(title: "Futurama", description: "Space cartoon.", created_at: 2.days.ago )
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.", created_at: 1.day.ago)
      back_to_future_two = Video.create(title: "Back to the Future 2", description: "Time travel movie 2.")
      expect(Video.search_by_title("utur")).to eq([back_to_future_two, back_to_future, futurama])
    end
    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: "Futurama", description: "Space cartoon.", created_at: 1.day.ago )
      back_to_future = Video.create(title: "Back to the Future", description: "Time travel movie.")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end