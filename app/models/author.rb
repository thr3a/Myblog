class Author < ActiveRecord::Base
  has_many :articles
  validates :scname, presence: true
  validates :image, presence: true
end
