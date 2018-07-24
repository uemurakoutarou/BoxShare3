class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User" #フォローされる方

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
