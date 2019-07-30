class Restraunt < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :title, uniqueness: true
  validates_presence_of :description
  validates_presence_of :google_map_link

  def self.find(params_id)
    all.find_by(id: params_id)
  end
end
