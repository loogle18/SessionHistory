require 'rails_helper'
require 'csv'

describe CreateSessionHistoryDataService do
  context 'perform' do
    it 'loads data from sample csv_file if no was given and creates histories instances' do
      expect(History.count).to eq(0)

      described_class.new.perform

      expect(History.count).to eq(108)
    end

    it 'loads data from sample given csv_file and creates histories instances' do
      expect(History.count).to eq(0)

      file = Rails.root.join('spec', 'fixtures', 'files', 'csv', 'custom_columns_order.csv')

      described_class.new(file).perform

      expect(History.count).to eq(3)
    end

    it 'loads data from sample given csv_file and creates histories instances even it has no header' do
      expect(History.count).to eq(0)

      file = Rails.root.join('spec', 'fixtures', 'files', 'csv', 'without_columns.csv')

      described_class.new(file).perform

      expect(History.count).to eq(3)
    end

    it 'breakes perform if given file does not exist' do
      file = Rails.root.join('spec', 'fixtures', 'files', 'csv', 'some_absent_file.csv')

      expect(described_class.new(file).perform).to eq(nil)
    end

    it 'breakes perform if given file is not csv' do
      file = Rails.root.join('spec', 'factories', 'histories.rb')

      expect(described_class.new(file).perform).to eq(nil)
    end
  end

  context 'get_columns_map_from' do
    it 'gets default columns map if first line of file does not include columns' do
      file = CSV.open(Rails.root.join('spec', 'fixtures', 'files', 'csv', 'without_columns.csv'))
      result = described_class.new.send(:get_columns_map_from, file)

      expect(result).to eq(described_class::DEFAULT_COLUMNS_MAP)
    end

    it 'builds new columns map if first line of file includes columns' do
      file = CSV.open(Rails.root.join('spec', 'fixtures', 'files', 'csv', 'custom_columns_order.csv'))
      result = described_class.new.send(:get_columns_map_from, file)

      expected_columns_map = { created_at: 0, summary_status: 1, session_id: 2, started_by: 3,
                               duration: 4, worker_time: 5, bundle_time: 6, num_workers: 7, branch: 8,
                               commit_id: 9, started_tests_count: 10, skipped_tests_count: 11,
                               error_tests_count: 12, passed_tests_count: 13, failed_tests_count: 14,
                               pending_tests_count: 15 }

      expect(result).to eq(expected_columns_map)
    end
  end
end
