class Post < ApplicationRecord
	has_many :comments, dependent: :destroy
	belongs_to :user, optional: true
	belongs_to :language, optional: true

	validates :title, presence: true
	validates :content, presence: true
	mount_uploader :picture, PictureUploader

end
