class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  # 規約： "モデル名_id" => Follower_idになるので、follower_id <-> Userクラスの紐付け
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
