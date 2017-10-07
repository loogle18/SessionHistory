class History < ApplicationRecord
  has_one :test_count, dependent: :destroy

  scope :ordered_by_session_id, -> { order(session_id: :desc) }
end
