# :reek:IrresponsibleModule:
class Restaurant < ActiveRecord::Base
  has_many :reviews

  validates_uniqueness_of :name, :description, :location
  validates_presence_of :name, :description, :location
end
