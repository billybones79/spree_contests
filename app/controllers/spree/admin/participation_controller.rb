module Spree
  module Admin
    class ParticipationController < ResourceController

      def index
        @contest = Spree::Contest.includes(:participations).find(params[:id])
        @participations = @contest.participations
      end

      def destroy
        @participations = Spree::Parcticipation.find(params[:id])
        @contest = @participations.contest
        @participations.dstory
        redirect_to admin_contest_path(@contest)
      end

    end
  end
end
