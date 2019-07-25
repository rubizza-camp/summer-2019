require_relative 'gest'

module Registration
  def registered(id)
   Gest[id]
  end
 end