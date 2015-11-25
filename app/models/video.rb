class Video < ActiveRecord::Base
	belongs_to :category
	has_many :reviews, -> { order("created_at DESC") }
	has_many :queue_items

	validates :title, presence: true
	validates :description, presence: true

	def self.search_by_title(title)
		return [] if title.blank?
		title_search_arr = self.where("title LIKE ?", "%#{title}%").order("created_at DESC")
	end
end