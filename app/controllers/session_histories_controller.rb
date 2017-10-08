class SessionHistoriesController < ApplicationController
  SAMPLE_DATA_RECORDS_COUNT = 108.freeze

  before_action :load_sample_data_if_needed, only: :index

  def index
    histories = History.ordered_asc_by_create_at
    @builds_per_day = BuildPerDayDataCarrier.new(histories).get_builds_per_day_data
  end

  def load_sample_data_if_needed
    CreateSessionHistoryDataService.new.perform if History.count < SAMPLE_DATA_RECORDS_COUNT
  end
end
