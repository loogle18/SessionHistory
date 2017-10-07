class CreateSessionHistoryDataService
  REDUNDANT_SYMBOLS = '\"'
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
    commit_id: 9,
    started_tests_count: 10,
    passed_tests_count: 11,
    failed_tests_count: 12,
    pending_tests_count: 13,
    skipped_tests_count: 14,
    error_tests_count: 15
  }.freeze

  attr_reader :csv_file

  def initialize(csv_file = CSV_SAMPLE_DATA_FILE)
    @csv_file = csv_file
  end

  def perform
    histories = []
    opened_file = File.open(csv_file)
    columns_map = get_columns_map_from(opened_file.first)

    opened_file.each_line do |line|
      formatted_line = get_formatted_array(line)
      history = create_history(formatted_line, columns_map)
      history.create_test_count!(
        get_test_count_attributes(formatted_line, columns_map)
      ) unless history.test_count
      histories << history
    end.close

    histories
  end

  private

  def get_columns_map_from(first_line)
    # Check if it's line of columns' names. Presence of one of them is enough to be sure for most cases.
    if first_line.include?(SESSION_ID_COLUMN_NAME)
      order_map = {}
      get_formatted_array(first_line).each_with_index { |field, index| order_map[field.to_sym] = index }
      order_map
    else
      DEFAULT_COLUMNS_MAP
    end
  end

  def get_formatted_array(line)
    line.chomp.tr(REDUNDANT_SYMBOLS, '').split(',')
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

  def get_test_count_attributes(line, columns_map)
    {
      started: line[columns_map[:started_tests_count]],
      passed: line[columns_map[:passed_tests_count]],
      failed: line[columns_map[:failed_tests_count]],
      pending: line[columns_map[:pending_tests_count]],
      skipped: line[columns_map[:skipped_tests_count]],
      error: line[columns_map[:error_tests_count]]
    }
  end
end
