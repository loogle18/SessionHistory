class BuildPerDayDataCarrier
  FAILED_ONE_BY_ONE_PATTERN = /failed failed|error error|failed error|error failed/.freeze

  attr_reader :histories

  def initialize(histories)
    @histories = histories
  end

  def get_builds_per_day_data
    histories_grouped_by_day.each_with_object({}) do |(day, histories_array), data|
      statuses_array = histories_array.pluck(:summary_status)
      is_abnormal = is_abnormal(statuses_array)

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

  def is_abnormal(statuses_array)
    failed = statuses_array.count('failed')
    error = statuses_array.count('error')
    has_more_than_half_failed_builds = (Float(failed) + Float(error)) / statuses_array.count >= 0.5
    has_failed_or_error_builds_one_by_one = statuses_array.join(' ') =~ FAILED_ONE_BY_ONE_PATTERN
    has_more_than_half_failed_builds || !!has_failed_or_error_builds_one_by_one
  end

  def histories_grouped_by_day
    histories.group_by{ |history| history.created_at.strftime('%d.%m.%y') }
  end
end
