# frozen_string_literal: true

class History < ApplicationRecord
  PASSED_STATUS_NAME = 'passed'
  STOPPED_STATUS_NAME = 'stopped'
  FAILED_STATUS_NAME = 'failed'
  ERROR_STATUS_NAME = 'error'

  PASSED_STATUS_CODE = 0.freeze
  STOPPED_STATUS_CODE = 1.freeze
  FAILED_STATUS_CODE = 2.freeze
  ERROR_STATUS_CODE = 3.freeze

  SUMMARY_STATUS_NAME_TO_CODE = {
    PASSED_STATUS_NAME => PASSED_STATUS_CODE,
    STOPPED_STATUS_NAME => STOPPED_STATUS_CODE,
    FAILED_STATUS_NAME => FAILED_STATUS_CODE,
    ERROR_STATUS_NAME => ERROR_STATUS_CODE
  }.freeze

  scope :ordered_asc_by_create_at, -> { order(created_at: :asc) }
end
