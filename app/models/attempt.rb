class Attempt < ApplicationRecord
  # 🚅 add concerns above.

  # 🚅 add attribute accessors above.

  belongs_to :treasure_hunt
  belongs_to :user

  has_many :idea_responses
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :treasure_hunt
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :first_name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
