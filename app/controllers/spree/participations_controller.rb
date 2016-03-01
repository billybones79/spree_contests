module Spree
  class ParticipationsController < Spree::StoreController

    respond_to :js, :html
    def subscribe
      @participation = Spree::Participation.find(params[:id])
      @participation.subscribed = true
    end

    def create
      puts "aaaaaaaa"
      unless params[:terms]
        flash[:notice] = "vous n'avez pas accepté les termes"
        puts "pas de term"
        respond_to do |format|
          format.html { redirect_to(:back)and return }
         end
      end
      @participation = Spree::Participation.new(participation_params)

      unless @participation.save
        puts "unless"
        flash[:notice] = "le formulaire a été mal rempli ou le email existe deja"
        respond_to do |format|
          format.html { redirect_to(:back)and return }
        end
      end

      puts "assasasasasasasasasasasasasasasasasasasasasasas"
      respond_to do |format|
        format.html {}
        format.js {render :layout => false}
      end

    end




    def participation_params
      params.require(:participation).permit(:name, :email, :zip)
    end


  end
end
