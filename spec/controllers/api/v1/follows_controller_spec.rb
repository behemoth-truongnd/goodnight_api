require "rails_helper"

RSpec.describe Api::V1::FollowsController, type: :controller do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  context ".create" do
    it "when follow success" do
      post :create, params: { user_follower: { follow_user_id: user2.id } }
      expect(response).to have_http_status(200)
      expect(user1.followings.first).to eq(user2)
    end

    it "when follow us followed -> fail" do
      post :create, params: { user_follower: { follow_user_id: user2.id } }
      post :create, params: { user_follower: { follow_user_id: user2.id } }
      expect(response).to have_http_status(422)
    end
  end

  context ".destroy" do
    it "when unfollow success" do
      post :create, params: { user_follower: { follow_user_id: user2.id } }
      expect(user1.followings.first).to eq(user2)
      delete :destroy, params: { follow_user_id: user2.id }
      expect(response).to have_http_status(200)
      expect(user1.followings.first).to eq(nil)
    end

    it "when not found user want to unfollow" do
      delete :destroy, params: { follow_user_id: user2.id }
      expect(response).to have_http_status(404)
    end
  end
end
