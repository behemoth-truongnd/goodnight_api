require "rails_helper"

RSpec.describe Api::V1::Users::TimeTracksController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:time_track_sleep) { create(:time_track, user: user1, sleep_at: Time.current - 7.hours, wakeup_at: nil) }

  context ".index" do
    it "when check time tracks friend success" do
      allow(controller).to receive(:current_user).and_return(user1)
      allow(user1).to receive_message_chain(:followings, :find, :time_tracks, :order_sleep).and_return(user1.time_tracks.limit(1))
      get :index, params: { user_id: 1 }
      expect(JSON.parse(response.body)["data"].size).to eq 1
      expect(response).to have_http_status(200)
    end

    it "when check time of user not friend" do
      allow(controller).to receive(:current_user).and_return(user1)
      get :index, params: { user_id: 2 }
      expect(response).to have_http_status(404)
    end
  end
end
