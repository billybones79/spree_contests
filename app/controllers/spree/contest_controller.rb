module Spree
  class ContestController < Spree::StoreController

    respond_to :js, :html
    def show
      if params[:id]
       @contest = Spree::Contest.find(params[:id])
      else
        @contest = Spree::Contest.order(:date_end).last
      end

      unless @contest.date_begin < Date.today && @contest.date_end >=Date.today
        redirect_to(root_path) and return
      end

      @participation = Spree::Participation.new()
    end

    private
    def permitted_params
      [:participation => [:id, :name, :postal_code, :email]]
    end

  end
end
