class Fight < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :forecasts, dependent: :destroy
  has_many :judges, dependent: :destroy

  validates :date, :player_A, :player_B, :all_round, presence: true
end
