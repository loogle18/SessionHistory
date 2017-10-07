class CreateTestCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :test_counts do |t|
      t.integer :started
      t.integer :passed
      t.integer :failed
      t.integer :pending
      t.integer :skipped
      t.integer :error
      t.belongs_to :history, index: true, foreign_key: true

      t.timestamps
    end
  end
end
