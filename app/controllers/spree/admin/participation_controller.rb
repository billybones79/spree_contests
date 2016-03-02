module Spree
  module Admin
    class ParticipationController < ResourceController

      def index
        @contest = Spree::Contest.includes(:participations).find(params[:id])
        @participations = @contest.participations
      end

      def destroy
        @participation = Spree::Participation.find(params[:id])
        @contest = @participation.contest
        @participation.destroy
        redirect_to admin_contest_path(@contest)
      end

    end
  end
end
