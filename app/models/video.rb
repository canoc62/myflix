class Video < ActiveRecord::Base
	belongs_to :category
	has_many :reviews, -> { order("created_at DESC") }

	validates :title, presence: true
	validates :description, presence: true
	#validates_presence_of :title, :description, use this for many presence validations

	def self.search_by_title(title)
		return [] if title.blank?
		title_search_arr = self.where("title LIKE ?", "%#{title}%").order("created_at DESC")
	end
end