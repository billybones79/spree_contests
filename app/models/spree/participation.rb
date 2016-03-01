module Spree
  class Participation < Spree::Base
    require 'mailchimp'
    belongs_to :contest
    validates_uniqueness_of :email, :scope => :contest_id
    after_save :subscribe

    def subscribe
      puts subscribed
      if self.subscribed && self.contest.mailchimp_api_key && self.contest.mailchimp_list_id
        mailchimp =        Mailchimp::API.new(self.contest.mailchimp_api_key)
        puts({"id"=> self.contest.mailchimp_list_id,"email"=>{"email"  => self.email}})
        mailchimp.lists.subscribe(self.contest.mailchimp_list_id,
                                  { "email" => self.email
                                  })
      end
    end

  end
end


