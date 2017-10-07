class History < ApplicationRecord
  has_one :test_count, dependent: :destroy
end
