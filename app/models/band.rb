class Band < ActiveRecord::Base
  attr_accessible :name, :description, :price, :brand, :size, :color, :photo
  mount_uploader :photo, PhotoUploader

  has_and_belongs_to_many :users

  # validates(:name, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false})
  validates(:description, presence: true)
end