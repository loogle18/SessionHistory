# frozen_string_literal: true

require 'csv'

class CreateSessionHistoryDataService
  CSV_EXTENSION = '.csv'
  CSV_SAMPLE_DATA_FILE = Rails.root.join('lib', 'sample_data', 'csv', 'session_history.csv').freeze
  SESSION_ID_COLUMN_NAME = 'session_id'
  DEFAULT_COLUMNS_MAP = {
    session_id: 0,
    started_by: 1,
    created_at: 2,
    summary_status: 3,
    duration: 4,
    worker_time: 5,
    bundle_time: 6,
    num_workers: 7,
    branch: 8,
    commit_id: 9
  }.freeze

  attr_reader :csv_file

  def initialize(csv_file = CSV_SAMPLE_DATA_FILE)
    @csv_file = csv_file
  end

  def perform
    histories = []

    return unless csv_file.exist? && File.extname(csv_file) == CSV_EXTENSION

    opened_file = CSV.open(csv_file)
    columns_map = get_columns_map_from(opened_file)

    opened_file.readlines.each do |formatted_line|
      histories << create_history(formatted_line, columns_map)
    end

    opened_file.close

    histories
  end

  private

  def get_columns_map_from(file)
    first_line = file.first

    # Check if it's line of columns' names. Presence of one of them is enough to be sure for most cases.
    if first_line.include?(SESSION_ID_COLUMN_NAME)
      order_map = {}
      first_line.each_with_index { |field, index| order_map[field.to_sym] = index }
      order_map
    else
      file.rewind # Restore to read from first line again.

      DEFAULT_COLUMNS_MAP
    end
  end

  def create_history(line, columns_map)
    history = History.find_or_initialize_by(session_id: line[columns_map[:session_id]])
    history.update!(
      started_by: line[columns_map[:started_by]],
      created_at: line[columns_map[:created_at]],
      summary_status: History::SUMMARY_STATUS_TO_CODE[line[columns_map[:summary_status]]],
      duration: line[columns_map[:duration]],
      worker_time: line[columns_map[:worker_time]],
      bundle_time: line[columns_map[:bundle_time]],
      num_workers: line[columns_map[:num_workers]],
      branch: line[columns_map[:branch]],
      commit_id: line[columns_map[:commit_id]]
    )
    history
  end
end
