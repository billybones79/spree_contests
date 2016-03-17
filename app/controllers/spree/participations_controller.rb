module Spree
  class ParticipationsController < Spree::StoreController

    respond_to :js, :html
    def subscribe
      @participation = Spree::Participation.find(params[:id])
      @participation.subscribed = true
    end

    def create
      @contest = Spree::Contest.find(params[:contest_id])
      unless params[:terms]
        flash[:notice] = "Vous n'avez pas accepté les termes"
        redirect_to(:back) and return

      end

      @participation = Spree::Participation.new(participation_params)
      @participation.subscribed = !(params[:subscribed].blank?)
      @participation.contest = @contest


      unless verify_recaptcha(model: @participation)
        flash[:notice] = "Vous devez remplir le recaptcha."
        redirect_to(:back) and return
      end

      unless @participation.save
        flash[:notice] = "Le formulaire a été mal rempli ou le email est déjà entré."
        redirect_to(:back) and return
      end

      respond_to do |format|
        format.html {}
        format.js {render :layout => false}
      end

    end




    def participation_params
      params.require(:participation).permit(:name, :email, :zip, :subscribed, :contest_id)
    end


  end
end
