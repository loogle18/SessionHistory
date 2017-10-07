FactoryGirl.define do
  factory :test_count do
    started_tests_count 1
    passed_tests_count 1
    failed_tests_count 1
    pending_tests_count 1
    skipped_tests_count 1
    error_tests_count 1
    history nil
  end
end
