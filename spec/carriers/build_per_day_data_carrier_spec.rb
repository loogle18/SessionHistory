require 'rails_helper'

describe BuildPerDayDataCarrier do
  it 'groupes records by created_at' do
    grouped_histories = FactoryGirl.create_list(:history, 2, created_at: '2014-09-10 05:38:55 UTC')
    separate_history = FactoryGirl.create(:history, created_at: '2014-11-30 02:13:27 UTC')

    method_result = described_class.new(History.ordered_asc_by_create_at).send(:histories_grouped_by_day)
    expected_result = { '10.09.14' => grouped_histories, '30.11.14' => [separate_history] }

    expect(method_result).to eq(expected_result)
  end

  it 'builds data per day with date, summary_status count and duration sum' do
    FactoryGirl.create_list(:history, 2, created_at: '2014-10-27 03:11:45 UTC', summary_status: 2, duration: 350.5)
    FactoryGirl.create_list(:history, 2, created_at: '2014-09-10 05:38:55 UTC', summary_status: 1, duration: 14.25)
    FactoryGirl.create_list(:history, 2, created_at: '2014-09-10 05:38:55 UTC', summary_status: 0, duration: 114.25)
    FactoryGirl.create(:history, created_at: '2014-09-10 02:18:24 UTC', summary_status: 2, duration: 212.0)
    FactoryGirl.create(:history, created_at: '2014-09-10 08:19:07 UTC', summary_status: 2, duration: 412.761)

    method_result = described_class.new(History.ordered_asc_by_create_at).get_builds_per_day_data
    expected_result = [
      { date: '10.09.14', duration: 881.761, passed: 2, stopped: 2, failed: 2, error: 0, is_abnormal: true },
      { date: '27.10.14', duration: 701.0, passed: 0, stopped: 0, failed: 2, error: 0, is_abnormal: true }
    ]

    expect(method_result).to eq(expected_result)
  end

  context 'is_abnormal' do
    it 'returns false if statuses_array does not include any falied statuses' do
      expect(described_class.new(History.all).send(:is_abnormal, [0, 1])).to be(false)
    end

    it 'returns true if failed builds for day count more or equal standard deviation of all days times 3' do
      FactoryGirl.create_list(:history, 2, created_at: '2014-10-27 03:11:45 UTC', summary_status: 2, duration: 350.5)
      FactoryGirl.create_list(:history, 2, created_at: '2014-09-10 05:38:55 UTC', summary_status: 2, duration: 114.25)
      FactoryGirl.create(:history, created_at: '2014-09-10 02:18:24 UTC', summary_status: 2, duration: 212.0)
      FactoryGirl.create(:history, created_at: '2014-09-10 08:19:07 UTC', summary_status: 2, duration: 412.761)

      histories = History.ordered_asc_by_create_at
      statuses_array = [2, 2, 1, 2, 2, 2]

      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(true)
    end

    it 'returns false if failed builds for day count less than standard deviation of all days times 3' do
      FactoryGirl.create_list(:history, 2, created_at: '2014-10-27 03:11:45 UTC', summary_status: 2, duration: 350.5)
      FactoryGirl.create_list(:history, 2, created_at: '2014-09-10 05:38:55 UTC', summary_status: 2, duration: 114.25)
      FactoryGirl.create(:history, created_at: '2014-09-10 02:18:24 UTC', summary_status: 2, duration: 212.0)
      FactoryGirl.create(:history, created_at: '2014-09-10 08:19:07 UTC', summary_status: 2, duration: 412.761)

      histories = History.ordered_asc_by_create_at
      statuses_array = [2, 1, 1, 3, 0, 1]

      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(false)
    end
  end
end
