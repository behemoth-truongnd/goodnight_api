# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
puts "User Creating..."
user_attributes = 5.times.map do |i|
  { name: "Test user #{i + 1}" }
end
User.import(user_attributes)
puts "User Created"

# Create user_followers
puts "UserFollowers Creating..."
user_ids = User.pluck(:id)
user_follows = user_ids.map do |user_id|
  { user_id: user_id, follower_id: (user_ids - [user_id]).sample }
end
UserFollower.import(user_follows)
puts "UserFollower Created"

# Create time_tracks
puts "TimeTrack Creating..."
user_ids.each do |user_id|
  time_tracks = 5.times.map do |i|
    sleep_at = Time.current.beginning_of_day - (i + 1).days + (20..23).to_a.sample.hours + (0..60).to_a.sample.minutes
    { user_id: user_ids, sleep_at: sleep_at, wakeup_at: sleep_at + (7..9).to_a.sample.hours + (0..60).to_a.sample.minutes }
  end
  TimeTrack.import time_tracks
end
puts "TimeTrack Created"
