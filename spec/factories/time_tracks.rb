FactoryBot.define do
  factory :time_track do
    sleep_at { Time.current - 8.hours }
    wakeup_at { Time.current }
  end
end
