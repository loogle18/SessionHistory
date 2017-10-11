class BuildPerDayDataCarrier
  LOCAL_ANOMALY = 2.freeze

  attr_reader :histories

  def initialize(histories)
    @histories = histories
  end

  def get_builds_per_day_data
    histories_grouped_by_day.each_with_object({}) do |(day, histories_array), data|
      statuses_array = histories_array.map(&:summary_status)
      is_abnormal = is_abnormal(statuses_array)

      if data[day]
        data[day][:date] = day
        data[day][:duration] = histories_array.sum(&:duration)
        data[day][:passed] = statuses_array.count(History::PASSED_STATUS_CODE)
        data[day][:stopped] = statuses_array.count(History::STOPPED_STATUS_CODE)
        data[day][:failed] = statuses_array.count(History::FAILED_STATUS_CODE)
        data[day][:error] = statuses_array.count(History::ERROR_STATUS_CODE)
        data[day][:is_abnormal] = is_abnormal
      else
        data[day] = {
          date: day,
          duration: histories_array.sum(&:duration),
          passed: statuses_array.count(History::PASSED_STATUS_CODE),
          stopped: statuses_array.count(History::STOPPED_STATUS_CODE),
          failed: statuses_array.count(History::FAILED_STATUS_CODE),
          error: statuses_array.count(History::ERROR_STATUS_CODE),
          is_abnormal: is_abnormal
        }
      end
    end.values
  end

  private

  def statuses_per_day
    histories_grouped_by_day.values.map { |day_array| day_array.map(&:summary_status) }
  end

  def is_abnormal(statuses_array)
    return false unless statuses_array.include?(History::FAILED_STATUS_CODE)

    failed_builds_count = statuses_array.count(History::FAILED_STATUS_CODE)

    failed_builds_count >= avg_failed_builds + LOCAL_ANOMALY * standard_deviation_for_failed_builds_per_day
  end

  def standard_deviation_for_failed_builds_per_day
    @_standard_deviation_for_failed_builds_per_day ||= begin
      deviations = failed_builds_per_day.map { |day| (day - avg_failed_builds).abs**2 }
      variance = deviations.sum / deviations.size

      Math.sqrt(variance)
    end
  end

  def failed_builds_per_day
    @_failed_builds_per_day ||= statuses_per_day.map { |day| day.count(History::FAILED_STATUS_CODE) }
  end

  def avg_failed_builds
    @_avg_failed_builds ||= Float(failed_builds_per_day.sum) / failed_builds_per_day.size
  end

  def histories_grouped_by_day
    @_histories_grouped_by_day ||= histories.group_by{ |history| history.created_at.strftime('%d.%m.%y') }
  end
end
