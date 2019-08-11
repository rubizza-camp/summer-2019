# :reek:UtilityFunction
class ReviewCreator
  def call(params)
    comment = Review.create(params)
    comment.save
  end
end
