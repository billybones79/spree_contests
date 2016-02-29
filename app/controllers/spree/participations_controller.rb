module Spree
  class ParticipationsController < Spree::StoreController

    respond_to :js, :html
    def subscribe
      @participation = Spree::Participation.find(params[:id])
      @participation.subscribed = true
    end

    def create
      unless params[:terms]
        flash[:notice] = "vous n'avez pas accepté les termes"
        redirect_to(:back)
      end
      @participation = Spree::Participation.new(participation_params)

      unless @participation.save
        flash[:notice] = "le formulaire a été mal rempli"
        redirect_to(:back)
      end

    end




    def participation_params
      params.require(:participation).permit(:name, :email, :zip)
    end


  end
end
