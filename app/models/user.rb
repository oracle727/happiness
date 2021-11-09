class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # def active_for_authentication?

   scope :not_admin, -> { where(is_admin: false) }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         attachment :profile_image
         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :likes, dependent: :destroy
        #  has_many :liked_posts, through: :likes, source: :post　#試しに
         has_many :relationships, foreign_key: :following_id
         has_many :followings, through: :relationships, source: :follower
         has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
         has_many :followers, through: :reverse_of_relationships, source: :following, dependent: :destroy

  def is_follower_by?(user)
      reverse_of_relationships.find_by(following_id: user.id).present?
  end

     validates :name, uniqueness: true, length: {minimum: 2, maximum: 20}
end
