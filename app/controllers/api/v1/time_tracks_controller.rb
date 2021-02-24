module Api
  module V1
    class TimeTracksController < BaseController
      def index
        @pagy, @records = pagy(current_user.time_tracks.created_desc)
        render json: TimeTrackSerializer.new(@records).serialized_json
      end
    end
  end
end
