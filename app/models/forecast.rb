class Forecast < ActiveRecord::Base
  belongs_to :fight
  belongs_to :user

  validates :user_id, :fight_id, :support, presence: true
end
