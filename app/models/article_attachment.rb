class ArticleAttachment < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :article
end
