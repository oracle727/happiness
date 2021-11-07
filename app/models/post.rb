class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
def
  liked_by?(user)
  likes.where(user_id: user.id).exists?
end

validates :title, presence: true
validates :explanation, presence: true, length:{maximum: 500}

end
