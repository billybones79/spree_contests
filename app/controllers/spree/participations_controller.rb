module Spree
  class ParticipationsController < Spree::StoreController

    respond_to :js, :html
    def subscribe
      @participation = Spree::Participation.find(params[:id])
      @participation.subscribed = true
    end

    def create
      @participation = Spree::Participation.find(params[:id])
      @participation.subscribed = true
    end

  end
end
