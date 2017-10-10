require 'rails_helper'
require 'csv'

describe CreateSessionHistoryDataService do
  context 'perform' do
    it 'loads data from sample csv file if no was given and creates histories instances' do
      expect(History.count).to eq(0)

      described_class.new.perform

      expect(History.count).to eq(108)
    end

    it 'loads data from given csv file and creates histories instances' do
      expect(History.count).to eq(0)

      file = Rails.root.join('spec', 'fixtures', 'files', 'csv', 'custom_columns_order.csv')

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

    it 'breakes perform if given csv file has no headers' do
      file = Rails.root.join('spec', 'fixtures', 'files', 'csv', 'without_headers.csv')

      expect(described_class.new(file).perform).to eq([])
    end
  end
end
