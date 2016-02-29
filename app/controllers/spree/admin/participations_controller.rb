module Spree
  module Admin
    class ParticipationsController < ResourceController

      def index
        @contest = Spree::Contest.includes(:participations).find(params[:id])
        @participations = @contest.participations
      end

    end
  end
end
