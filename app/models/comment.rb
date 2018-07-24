class Comment < ActiveRecord::Base
  belongs_to :fight
  belongs_to :user
  has_many :likes ,dependent: :destroy
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy

  validates :user_id, :fight_id, presence: true

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    liked_users.include?(user)
  end
end
