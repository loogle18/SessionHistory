class SessionHistoriesController < ApplicationController
  def index
    histories = History.ordered_asc_by_create_at
    @builds_per_day = BuildPerDayDataCarrier.new(histories).get_builds_per_day_data
  end
end
