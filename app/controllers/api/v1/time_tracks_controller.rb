module Api
  module V1
    class TimeTracksController < BaseController
      before_action :build_time_track, only: :create

      def index
        @pagy, @records = pagy(current_user.time_tracks.created_desc)
        render json: TimeTrackSerializer.new(@records).serialized_json
      end

      def create
        if @time_track.save
          render json: { status: :ok }
        else
          render status: :unprocessable_entity, json: {
            errors: { message: @time_track.errors.to_hash(true) }
          }
        end
      end

      private

      def build_time_track
        @time_track = current_user.in_sleep
        if @time_track
          @time_track.wakeup_at = Time.current
        else
          @time_track = current_user.build_in_sleep(sleep_at: Time.current)
        end
      end
    end
  end
end
