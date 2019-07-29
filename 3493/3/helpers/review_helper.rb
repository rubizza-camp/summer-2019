class ReviewHelper
  def self.create_review(hash)
    Review.create(title: hash[:title], description: hash[description], place_id: hash[place_id],
                  user_id: hash[user_id], rating: hash[rating])
  end
end
