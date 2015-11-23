require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
  	it "returns the videos in the reverse chronological order by created at" do
  		action = Category.create(name: "Action Movie")
      avengers = Video.create(title: "The Avengers", description: "Marvel's The Avengers.", category: action, created_at: 1.day.ago)
      xmen = Video.create(title: "X-Men", description: "Marvel's X-Men.", category: action)
      expect(action.recent_videos).to eq([xmen, avengers])
    end
  	it "returns all the videos if there are less than or equal to 6 videos" do
      action = Category.create(name: "Action Movie")
      avengers = Video.create(title: "The Avengers", description: "Marvel's The Avengers.", category: action, created_at: 1.day.ago)
      xmen = Video.create(title: "X-Men", description: "Marvel's X-Men.", category: action)
      expect(action.recent_videos.count).to eq(2)
    end
  	it "returns 6 videos if there are more than 6 videos" do
      action = Category.create(name: "Action Movie")
      spiderman = Video.create(title: "Spiderman", description: "Marvel's Spiderman.", category: action, created_at: 6.days.ago)
      green_lantern = Video.create(title: "Green Lantern", description: "DC's Green Lantern.", category: action, created_at: 5.days.ago)
      punisher = Video.create(title: "The Punisher", description: "Marvel's The Punisher.", category: action, created_at: 4.days.ago )
      superman = Video.create(title: "Superman", description: "DC's Superman.", category: action, created_at: 3.days.ago)
      batman = Video.create(title: "Batman", description: "DC's Batman.", category: action, created_at: 2.days.ago)
      avengers = Video.create(title: "The Avengers", description: "Marvel's The Avengers.", category: action, created_at: 1.day.ago)
      xmen = Video.create(title: "X-Men", description: "Marvel's X-Men.", category: action)
      expect(action.recent_videos.count).to eq(6)
    end
  	it "return the most recent 6 videos" do
      action = Category.create(name: "Action Movie")
      spiderman = Video.create(title: "Spiderman", description: "Marvel's Spiderman.", category: action, created_at: 6.days.ago)
      green_lantern = Video.create(title: "Green Lantern", description: "DC's Green Lantern.", category: action, created_at: 5.days.ago)
      punisher = Video.create(title: "The Punisher", description: "Marvel's The Punisher.", category: action, created_at: 4.days.ago )
      superman = Video.create(title: "Superman", description: "DC's Superman.", category: action, created_at: 3.days.ago)
      batman = Video.create(title: "Batman", description: "DC's Batman.", category: action, created_at: 2.days.ago)
      avengers = Video.create(title: "The Avengers", description: "Marvel's The Avengers.", category: action, created_at: 1.day.ago)
      xmen = Video.create(title: "X-Men", description: "Marvel's X-Men.", category: action)
      expect(action.recent_videos).to eq([xmen, avengers, batman, superman, punisher, green_lantern])
    end
  	it "returns an empty array if the category does not have any videos" do
      action = Category.create(name: "Action Movie")
      expect(action.recent_videos).to eq([])
    end
  end
end