class Review < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  def user_email
    user.email
  end
end
