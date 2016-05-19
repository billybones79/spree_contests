module Spree
  class Contest < Spree::Base
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :finders]
    has_many :participations, :dependent => :destroy
    belongs_to :selected_winner, class_name: 'Participation'
    before_save :generate_slug


    def subscription_number
      participations.count
    end
    def opt_in_number
      participations.where(subscribed: :true).count
    end
    def opt_in_rate
      ((opt_in_number.to_f/subscription_number.to_f)*100).round(2)
    end

    def slug_candidates
      [:name]
    end

    def generate_slug
      self.slug = name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') unless self.slug.present?
    end
    def select_winner
      opted_in_vote_count = self.participations.where(subscribed: :true).count*2

      not_opted_in_vote_count = self.participations.where(subscribed: :false).count
      selected = rand(0..(opted_in_vote_count + not_opted_in_vote_count))
      if selected < opted_in_vote_count
        self.selected_winner = self.participations.where(subscribed: :true).limit(1).offset((selected/2).floor).first
      else
        self.selected_winner = self.participations.where(subscribed: :false).limit(1).offset(selected - opted_in_vote_count).first
      end
      self.save
      puts "/*********************************/"
      puts "SELECTING WINER"

      puts "opted_in vote : "+opted_in_vote_count.to_s
      puts "not opted_in vote : "+not_opted_in_vote_count.to_s
      puts "random picked : "+selected.to_s
      puts selected_winner.inspect
      puts "/*********************************/"

    end

    def self.active_contest
       contest = Spree::Contest.where("date_begin < NOW()").where("date_end >= NOW()").order(:date_begin).last()
    end

    def to_csv
      CSV.generate do |csv|
        csv << Spree::Participation.column_names
        participations.each do |part|
          csv << part.attributes.values_at(*Spree::Participation.column_names)
        end
      end
    end

  end
end