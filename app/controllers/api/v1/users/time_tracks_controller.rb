module Api
  module V1
    module Users
      class TimeTracksController < BaseController
        def index
          @time_tracks = current_user.followings.find(params[:user_id]).time_tracks.order_sleep
          @pagy, @records = pagy(@time_tracks)
          render json: TimeTrackSerializer.new(@records).serialized_json
        end
      end
    end
  end
end
