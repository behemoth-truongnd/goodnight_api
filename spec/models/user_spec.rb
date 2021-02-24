require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:user_followers) }
    it { should have_many(:followers).through(:user_followers) }
    it { should have_many(:user_followings).class_name("UserFollower").with_foreign_key(:follower_id) }
    it { should have_many(:followings).through(:user_followings).source(:user) }
    it { should have_many(:time_tracks) }
    it { should have_one(:in_sleep).conditions(wakeup_at: nil) }
  end
end
