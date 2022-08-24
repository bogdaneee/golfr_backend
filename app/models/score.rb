# Model to represent a score played by a golfer
# - total_score: total number of hits to finish all 18 holes
# - played_at: date when the score was played
class Score < ApplicationRecord
  belongs_to :user

  validates :total_score, inclusion: { in: 27..180 }
  validates :number_of_holes, inclusion: { in: [9, 18] }
  validate :range_score
  validate :future_score

  def serialize
    {
      id: id,
      user_id: user_id,
      user_name: user.name,
      total_score: total_score,
      played_at: played_at,
      number_of_holes: number_of_holes
    }
  end

  private

  def future_score
    errors.add(:played_at, 'must not be in the future') if played_at > Time.zone.today
  end

  def range_score
    interval = 0
    interval = (27..89) if number_of_holes == 9
    interval = (54..179) if number_of_holes == 18
    errors.add(:total_score, "must be between #{interval}") unless interval.cover? total_score
  end
end
