FactoryGirl.define do
  factory :history do
    session_id 1
    started_by "MyString"
    summary_status 1
    duration 1.5
    worker_time 1.5
    bundle_time 1
    num_workers 1
    branch "MyString"
    commit_id "MyString"
  end
end
