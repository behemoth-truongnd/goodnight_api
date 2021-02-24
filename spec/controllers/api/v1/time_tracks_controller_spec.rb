require "rails_helper"

RSpec.describe Api::V1::TimeTracksController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:time_track_sleep) { create(:time_track, user: user1, sleep_at: Time.current - 7.hours, wakeup_at: nil) }

  context ".index" do
    before do
      allow(controller).to receive(:current_user).and_return(user1)
    end

    it "when have record" do
      allow(user1).to receive_message_chain(:time_tracks, :created_desc).and_return(user1.time_tracks.limit(1))
      get :index
      expect(JSON.parse(response.body)["data"].size).to eq 1
      expect(response).to have_http_status(200)
    end

    it "when record blank" do
      allow(user1).to receive_message_chain(:time_tracks, :created_desc).and_return(user1.time_tracks.limit(1))
      get :index
      expect(JSON.parse(response.body)["data"].size).to eq 1
      expect(response).to have_http_status(200)
    end
  end

  context ".create" do
    it "when in sleep" do
      allow(controller).to receive(:current_user).and_return(user1)
      allow(user1).to receive(:in_sleep).and_return(time_track_sleep)
      post :create
      expect(time_track_sleep.wakeup_at).to be_truthy
      expect(response).to have_http_status(200)
    end

    it "when wakeup" do
      allow(controller).to receive(:current_user).and_return(user2)
      allow(user2).to receive(:in_sleep).and_return(nil)
      post :create
      expect(user2.time_tracks.count).to eq(1)
      expect(user2.time_tracks.last.sleep_at).to be_truthy
      expect(user2.time_tracks.last.wakeup_at).to eq(nil)
      expect(response).to have_http_status(200)
    end
  end
end
