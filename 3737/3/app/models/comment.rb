class Comment < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :restaraunt, dependent: :destroy

  validates_presence_of :text, :star
end
