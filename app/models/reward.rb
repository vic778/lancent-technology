class Reward < ApplicationRecord
  reward_type_options = %w[Coffee Ticket 4xAirport]
  belongs_to :user
  validates :reward_type, inclusion: { in: reward_type_options }
end
