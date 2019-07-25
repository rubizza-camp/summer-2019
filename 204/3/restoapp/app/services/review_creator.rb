class ReviewCreator
  attr_reader :id, :body, :rate, :account_id, :restraunt

  def initialize(params, session, restraunt)
    @id = Review.find_id(restraunt)
    @body = params[:body]
    @rate = params[:rate]
    @account_id = session[:account_id]
    @restraunt = restraunt
  end

  def call
    restraunt.reviews.create!(
      id: id,
      body: body,
      rate: rate,
      account_id: account_id
    )
    restraunt.update(avg_rate: median(restraunt.reviews))
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
