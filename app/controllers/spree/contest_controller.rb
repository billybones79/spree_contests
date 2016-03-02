module Spree
  class ContestController < Spree::StoreController

    respond_to :js, :html
    def show
      @contest = Spree::Contest.find(params[:id])
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
