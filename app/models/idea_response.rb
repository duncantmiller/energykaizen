class IdeaResponse < ApplicationRecord
  belongs_to :attempt
  belongs_to :idea
end
