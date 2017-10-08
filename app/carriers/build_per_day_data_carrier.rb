class BuildPerDayDataCarrier
  attr_reader :histories

  def initialize(histories)
    @histories = histories
  end

  def get_builds_per_day_data
    passed = History::SUMMARY_STATUS_TO_CODE[(History::PASSED_STATUS)]
    stopped = History::SUMMARY_STATUS_TO_CODE[(History::STOPPED_STATUS)]
    failed = History::SUMMARY_STATUS_TO_CODE[(History::FAILED_STATUS)]
    error = History::SUMMARY_STATUS_TO_CODE[(History::ERROR_STATUS)]

    histories_grouped_by_day.each_with_object({}) do |(day, histories_array), data|
      statuses_array = histories_array.pluck(:summary_status)

      if data[day]
        data[day][:date] = day
        data[day][:duration] = histories_array.sum(&:duration)
        data[day][:passed] = statuses_array.count(passed)
        data[day][:stopped] = statuses_array.count(stopped)
        data[day][:failed] = statuses_array.count(failed)
        data[day][:error] = statuses_array.count(error)
      else
        data[day] = {
          date: day,
          duration: histories_array.sum(&:duration),
          passed: statuses_array.count(passed),
          stopped: statuses_array.count(stopped),
          failed: statuses_array.count(failed),
          error: statuses_array.count(error)
        }
      end
    end.values
  end

  private

  def histories_grouped_by_day
    histories.group_by{ |history| history.created_at.strftime("%Y-%m-%d") }
  end
end
