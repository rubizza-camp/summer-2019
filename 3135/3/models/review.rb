# :reek:UncommunicativeVariableName:
# :reek:IrresponsibleModule:
class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :rating, inclusion: { in: 0..5, message: 'Rating should be an integer from 1-5!' }
  validates :description,
            presence: { message: 'is necessary when leaving such low rating!' },
            if: proc { |a| a.rating < 4 }
end
