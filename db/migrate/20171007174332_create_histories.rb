class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.integer :session_id, null: false
      t.string :started_by, null: false
      t.integer :summary_status, null: false
      t.float :duration
      t.float :worker_time
      t.integer :bundle_time
      t.integer :num_workers
      t.string :branch, null: false
      t.string :commit_id, null: false

      t.timestamps
    end
  end
end
