module Api
  module V1
    class RatingEventsController < BaseController
      before_action :initialize_framework

      def initialize_framework
        rating_type = params[:rating_type] || "vendor"
        @rating_framework = RatingFramework.find_by_name(rating_type)
      end

      def get_data
        #add validation (code.present? and valid event present?)
        @event = @rating_framework.rating_events.find_by_code(params[:event_code])
        @data = @event.get_data
      end
    end
  end
end
