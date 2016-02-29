module Spree
  class Participation < Spree::Base
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :finders]
    belongs_to :contest
    validates_uniqueness_of :email, :scope => :contest_id

    def slug_candidates
      [:email]
    end
  end
end


