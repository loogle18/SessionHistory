class SessionHistoriesController < ApplicationController
  SAMPLE_DATA_RECORDS_COUNT = 108.freeze

  before_action :load_sample_data_if_needed, only: :index

  def index
    @histories = History.includes(:test_count).ordered_by_session_id
  end

  def load_sample_data_if_needed
    CreateSessionHistoryDataService.new.perform if History.count < SAMPLE_DATA_RECORDS_COUNT
  end
end
