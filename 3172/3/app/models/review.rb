class Review < ActiveRecord::Base
  belongs_to :place, counter_cache: true
  validates :text, presence: true
end
