class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant
	validates :mark, :inclusion => { :in => 1..5 }
	validates :description, presence: {message: 'should exists if grade so low'}, if: :low_grade? 
	 
    def low_grade?
      [1,2].include? mark
    end
end
