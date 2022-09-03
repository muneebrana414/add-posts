class Post < ApplicationRecord
	validates :title, presence: true
	validates :description, presence: true

	belongs_to :user
	has_many :comments
	has_many_attached :pictures
end
