class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order(:position) }
  validates_presence_of :password, :full_name
  validates :email, presence: true, uniqueness: true
  has_secure_password validations: false
end