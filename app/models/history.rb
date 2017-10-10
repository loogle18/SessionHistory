class History < ApplicationRecord
  scope :ordered_asc_by_create_at, -> { order(created_at: :asc) }
end
