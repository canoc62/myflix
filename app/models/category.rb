class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC") }

  def recent_videos
  	#return [] if videos.nil?
  	recent_vids = videos.first(6)#self.videos.where("created_at DESC")
  end
end