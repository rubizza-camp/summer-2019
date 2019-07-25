class Review < ActiveRecord::Base
  belongs_to :restraunts
  belongs_to :accounts

  def self.find_id(restraunt)
    all.last.id + 1 if restraunt.reviews.any?
  end
end
