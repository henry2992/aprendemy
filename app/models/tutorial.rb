class Tutorial < ActiveRecord::Base
  validates :title, :description, presence: true
  belongs_to :sub_category
  belongs_to :material, :polymorphic => true

  # Picture Uploader
  mount_uploader :picture, PictureUploader if Rails.env == "production"
  mount_uploader :picture, PicUploader unless Rails.env == "production"

end
