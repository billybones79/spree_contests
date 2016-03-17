module Spree
  module Admin
    class ContestsController < ResourceController

      def index
        @contests = Spree::Contest.all
      end

      def select_winner
        @contest = Spree::Contest.includes(:participations).find(params[:id])
        @contest.select_winner
        redirect_to admin_contest_path(@contest)
      end
      def show
        @contest = Spree::Contest.find(params[:id])
        respond_to do |format|
          format.html
          format.csv { send_data @contest.to_csv }
        end
      end

    end
  end
end
