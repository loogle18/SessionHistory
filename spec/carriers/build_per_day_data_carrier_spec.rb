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
    FactoryGirl.create_list(:history, 2, created_at: '2014-10-27 03:11:45 UTC', summary_status: 'error', duration: 350.5)
    FactoryGirl.create_list(:history, 2, created_at: '2014-09-10 05:38:55 UTC', summary_status: 'passed', duration: 114.25)
    FactoryGirl.create(:history, created_at: '2014-09-10 02:18:24 UTC', summary_status: 'stopped', duration: 212.0)
    FactoryGirl.create(:history, created_at: '2014-09-10 08:19:07 UTC', summary_status: 'failed', duration: 412.761)

    method_result = described_class.new(History.ordered_asc_by_create_at).get_builds_per_day_data
    expected_result = [
      { date: '10.09.14', duration: 853.261, passed: 2, stopped: 1, failed: 1, error: 0, is_abnormal: false },
      { date: '27.10.14', duration: 701.0, passed: 0, stopped: 0, failed: 0, error: 2, is_abnormal: true }
    ]

    expect(method_result).to eq(expected_result)
  end

  context 'is_abnormal' do
    histories = History.all

    it 'returns false if there are no enough failed or error builds and there no these builds one after another' do
      statuses_array = ['failed', 'passed', 'stopped', 'error', 'passed', 'passed']

      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(false)
    end

    it 'returns true if there are enough failed or error builds' do
      statuses_array = ['failed', 'passed', 'stopped', 'error', 'passed', 'failed']

      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(true)
    end

    it 'returns true if failed or error builds go one after another' do
      statuses_array = ['stopped', 'passed', 'failed', 'error', 'stopped', 'passed']
      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(true)

      statuses_array = ['error', 'failed', 'stopped', 'passed', 'stopped', 'passed']
      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(true)

      statuses_array = ['failed', 'failed', 'stopped', 'passed', 'stopped', 'passed']
      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(true)

      statuses_array = ['passed', 'passed', 'stopped', 'passed', 'error', 'error']
      expect(described_class.new(histories).send(:is_abnormal, statuses_array)).to be(true)
    end
  end
end
