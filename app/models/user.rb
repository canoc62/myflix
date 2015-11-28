class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order(:position) }
  validates_presence_of :password, :full_name
  validates :email, presence: true, uniqueness: true
  has_secure_password validations: false


  def normalize_queue_item_positions
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: (index + 1) )
    end
  end

  def queued_video?(video)
  	queue_items.map(&:video).include?(video)
  end

end