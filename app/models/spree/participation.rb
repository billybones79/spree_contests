module Spree
  class Participation < Spree::Base
    require 'mailchimp'
    belongs_to :contest
    validates_uniqueness_of :email, :scope => :contest_id
    before_save :add_to_mailchimp

    before_validation :upcase_zip
    canadian_postal_code = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$\z/
    validates :zip, format: { with: canadian_postal_code }

    def add_to_mailchimp
      begin
        if self.subscribed && self.contest.mailchimp_api_key && self.contest.mailchimp_list_id
          mailchimp =       Mailchimp::API.new(self.contest.mailchimp_api_key)
          mailchimp.lists.subscribe(self.contest.mailchimp_list_id, { "email" => self.email})
        end
      rescue Mailchimp::ValidationError => e
        errors.add(:email, "invalide")
        false
      rescue Mailchimp::Error => e
        errors.add(:email, "invalide")
        false
      rescue Mailchimp::ListAlreadySubscribedError => e
        true
      end
    end

    def upcase_zip
      self.zip = self.zip.upcase if self.zip.present?
    end

  end
end


