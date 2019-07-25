require_relative 'gest'
#:reek:UtilityFunction
module Registration
  def registered(id)
    Gest[id]
  end
end
