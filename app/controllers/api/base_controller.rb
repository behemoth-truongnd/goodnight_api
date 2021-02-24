module Api
  class BaseController < ::ApplicationController
    include Pagy::Backend
    after_action :set_pagy_headers

    rescue_from ActionController::RoutingError, with: :render404
    rescue_from ActiveRecord::RecordNotFound, with: :render404
    rescue_from StandardError, with: :render500

    def render500(exception)
      write_log(exception)
      render status: 500, json: { errors: { message: "Server error" } }
    end

    def render404
      write_log(exception)
      render status: 404, json: { errors: { message: "Not Found" } }
    end

    def current_user
      @current_user ||= User.find(params[:user_id])
    end

    private

    def set_pagy_headers
      return if @pagy.blank?

      pagy_headers_merge(@pagy)
    end

    def write_log(exception)
      Rails.logger.error exception.backtrace.join("\n")
      Rails.logger.error exception.message
    end
  end
end
