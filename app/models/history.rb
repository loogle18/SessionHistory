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

  SUMMARY_STATUS_CODE_TO_NAME = {
    0 => PASSED_STATUS,
    1 => STOPPED_STATUS,
    2 => FAILED_STATUS,
    3 => ERROR_STATUS
  }.freeze

  has_one :test_count, dependent: :destroy

  scope :ordered_asc_by_create_at, -> { order(created_at: :asc) }

  def summary_status_name
    SUMMARY_STATUS_CODE_TO_NAME[summary_status]
  end
end
