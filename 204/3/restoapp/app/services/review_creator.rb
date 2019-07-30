class ReviewCreator
  def call(params, session, restraunt)
    restraunt.reviews.create!(
      id: Review.find_id(restraunt),
      body: params[:body],
      rate: params[:rate],
      account_id: session[:account_id]
    )
    restraunt.update(avg_rate: median(restraunt.reviews))
  end

  private

  def median(reviews)
    array = []
    reviews.map { |review| array.push(review.rate) }
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end
