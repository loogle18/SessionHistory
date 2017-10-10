class BuildPerDayDataCarrier
  attr_reader :histories

  def initialize(histories)
    @histories = histories
  end

  def get_builds_per_day_data
    histories_grouped_by_day.each_with_object({}) do |(day, histories_array), data|
      statuses_array = histories_array.pluck(:summary_status)
      is_abnormal = calculate_is_abnormal(statuses_array.count('failed'),
                                          statuses_array.count('error'),
                                          statuses_array.count)

      if data[day]
        data[day][:date] = day
        data[day][:duration] = histories_array.sum(&:duration)
        data[day][:passed] = statuses_array.count('passed')
        data[day][:stopped] = statuses_array.count('stopped')
        data[day][:failed] = statuses_array.count('failed')
        data[day][:error] = statuses_array.count('error')
        data[day][:is_abnormal] = is_abnormal
      else
        data[day] = {
          date: day,
          duration: histories_array.sum(&:duration),
          passed: statuses_array.count('passed'),
          stopped: statuses_array.count('stopped'),
          failed: statuses_array.count('failed'),
          error: statuses_array.count('error'),
          is_abnormal: is_abnormal
        }
      end
    end.values
  end

  private

  def calculate_is_abnormal(failed, error, count)
    (Float(failed) + Float(error)) / count >= 0.5
  end

  def histories_grouped_by_day
    histories.group_by{ |history| history.created_at.strftime("%d.%m.%y") }
  end
end
