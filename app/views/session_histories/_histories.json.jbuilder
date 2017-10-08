json.array!(@histories) do |history|
  json.extract! history, :session_id, :started_by, :created_at, :summary_status_name, :duration,
                         :worker_time, :bundle_time, :num_workers, :branch, :commit_id
  json.test_count do
    json.extract! history.test_count, :started, :passed, :failed, :pending, :skipped, :error
  end
end
