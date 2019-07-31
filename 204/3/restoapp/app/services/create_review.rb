class CreateReview
  def call(params, session)
    restraunt = Restraunt.find(params[:id])
    restraunt.reviews.create!(
      id: Review.next_id(restraunt),
      body: params[:body],
      rate: params[:rate],
      account_id: session[:account_id]
    )
    restraunt.update(avg_rate: median(restraunt.reviews))
    params
  end

  private

  # :reek:all
  def median(reviews)
    array = []
    reviews.map { |review| array.push(review.rate) }
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end
