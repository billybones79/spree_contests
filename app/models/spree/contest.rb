module Spree
  class Contest < Spree::Base
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :finders]
    has_many :participations
    before_save :generate_slug


    def slug_candidates
      [:name]
    end
    def generate_slug
      self.slug = name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.active_contest
      contest = Spree::Contest.where("date_begin < NOW()").where("date_end >= NOW()").order(:date_begin).last()
    end
  end
end