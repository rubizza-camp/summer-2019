require_relative 'Guest'
#:reek:UtilityFunction
module Registration
  def registered(id)
    Guest[id]
  end
end
