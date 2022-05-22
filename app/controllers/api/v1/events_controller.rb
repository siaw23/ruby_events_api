module Api
  module V1
    class EventsController < ApplicationController
      def index
        @events = Event.upcoming
        render json: @events, each_serializer: EventSerializer
      end
    end
  end
end
