# frozen_string_literal: true

class History < ApplicationRecord
  PASSED_STATUS = 'passed'
  STOPPED_STATUS = 'stopped'
  FAILED_STATUS = 'failed'
  ERROR_STATUS = 'error'

  SUMMARY_STATUS_TO_CODE = {
    PASSED_STATUS => 0,
    STOPPED_STATUS => 1,
    FAILED_STATUS => 2,
    ERROR_STATUS => 3
  }.freeze

  scope :ordered_asc_by_create_at, -> { order(created_at: :asc) }
end
