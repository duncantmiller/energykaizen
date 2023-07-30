class Attempt < ApplicationRecord
  belongs_to :treasure_hunt
  belongs_to :user

  has_many :idea_responses
end
