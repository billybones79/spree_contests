module Spree
  class Participation < Spree::Base
    belongs_to :contest
    validates_uniqueness_of :email, :scope => :contest_id

  end
end


