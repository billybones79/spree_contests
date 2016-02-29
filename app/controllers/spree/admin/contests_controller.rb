module Spree
  module Admin
    class ContestsController < ResourceController

      def index
        @contests = Spree::Contest.all
      end

    end
  end
end
