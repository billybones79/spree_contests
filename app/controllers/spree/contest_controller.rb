module Spree
  class ContestController < Spree::StoreController

    def show
      @contest = Spree::Contest.find(params[:id])
      @participation = Spree::Participation.new()
    end
    private

    def permitted_params
      [:participation => [:id, :name, :postal_code, :email]]
    end

  end
end
