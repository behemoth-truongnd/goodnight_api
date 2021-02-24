module Api
  module V1
    class FollowsController < BaseController
      def create
        @user_following = current_user.user_followings.new(user_id: user_follower_params[:follow_user_id])
        if @user_following.save
          render json: { status: :ok }
        else
          render status: :unprocessable_entity, json: {
            errors: { message: @user_following.errors.to_hash(true) }
          }
        end
      end

      def destroy
        @user_following = current_user.user_followings.find_by!(user_id: params[:follow_user_id])
        if @user_following.destroy
          render json: { status: :ok }
        else
          render status: :unprocessable_entity, json: {
            errors: { message: @user_following.errors.to_hash(true) }
          }
        end
      end

      private

      def user_follower_params
        params.require(:user_follower).permit(:follow_user_id)
      end
    end
  end
end
