# frozen_string_literal: true

require 'csv'

class CreateSessionHistoryDataService
  CSV_EXTENSION = '.csv'
  NEEDED_HEADERS = %i(session_id started_by created_at summary_status duration worker_time bundle_time
                      num_workers branch commit_id).freeze
  CSV_SAMPLE_DATA_FILE_PATH = Rails.root.join('lib', 'sample_data', 'csv', 'session_history.csv').freeze

  attr_reader :pathname

  def initialize(pathname = CSV_SAMPLE_DATA_FILE_PATH)
    @pathname = pathname
  end

  def perform
    return unless pathname.exist? && File.extname(pathname) == CSV_EXTENSION

    CSV.foreach(pathname, headers: true, header_converters: [:symbol]) do |row|
      create_history(row) if (row.headers & NEEDED_HEADERS).size == NEEDED_HEADERS.size
    end
  end

  private

  def create_history(row)
    history = History.find_or_initialize_by(session_id: row[:session_id])
    history.update!(
      started_by: row[:started_by],
      created_at: row[:created_at],
      summary_status: row[:summary_status],
      duration: row[:duration],
      worker_time: row[:worker_time],
      bundle_time: row[:bundle_time],
      num_workers: row[:num_workers],
      branch: row[:branch],
      commit_id: row[:commit_id]
    )
    history
  end
end
