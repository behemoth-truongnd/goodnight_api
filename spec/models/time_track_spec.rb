require "rails_helper"

RSpec.describe TimeTrack, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "scope" do
    let(:time_now) { Time.current }
    let(:user) { create(:user) }
    let!(:time_track) do
      create(:time_track, sleep_at: time_now, wakeup_at: time_now + 6.hours, created_at: time_now - 1.days,
                          user_id: user.id)
    end
    let!(:time_track1) do
      create(:time_track, sleep_at: time_now, wakeup_at: time_now + 10.hours, created_at: time_now - 8.days,
                          user_id: user.id)
    end
    let!(:time_track2) do
      create(:time_track, sleep_at: time_now, wakeup_at: time_now + 8.hours, created_at: time_now - 2.days,
                          user_id: user.id)
    end

    it ".created_desc" do
      expect(user.time_tracks.created_desc).to eq([time_track, time_track2, time_track1])
    end

    it ".order_sleep" do
      expect(user.time_tracks.order_sleep).to eq([time_track1, time_track2, time_track])
    end

    it ".in_last_week" do
      expect(user.time_tracks.in_last_week).to eq([time_track, time_track2])
    end
  end

  describe "methods" do
    let(:time_now) { Time.current }
    let(:user) { create(:user) }
    let(:time_track) do
      create(:time_track, sleep_at: time_now, wakeup_at: time_now + 6.hours + 2.minutes, user_id: user.id)
    end
    let(:time_track1) do
      create(:time_track, sleep_at: time_now, wakeup_at: time_now + 30.hours + 6.minutes, user_id: user.id)
    end
    let(:time_track2) { create(:time_track, sleep_at: time_now, wakeup_at: nil, user_id: user.id) }
    let(:time_track3) { create(:time_track, sleep_at: nil, wakeup_at: nil, user_id: user.id) }
    context ".sleep_time" do
      it "when sleep_time > 24hours" do
        expect(time_track1.sleep_time).to eq("30:06:00")
      end

      it "when sleep_time < 24hours" do
        expect(time_track.sleep_time).to eq("06:02:00")
      end

      it "when wakeup_at blank" do
        expect(time_track2.sleep_time).to eq(nil)
      end

      it "when sleep_at blank" do
        expect(time_track3.sleep_time).to eq(nil)
      end
    end
  end
end
