class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :latitude, :longitude

  def already_reviewed?(current_user_id)
    review = reviews.find_by(user_id: current_user_id)
    return false unless review
    review.user_id == current_user_id
  end

  def update_average_grade
    self.average_grade = reviews.average(:grade).to_f
    save
  end
end
