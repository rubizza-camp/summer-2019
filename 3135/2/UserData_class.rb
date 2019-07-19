class UserData
  attr_reader :id, :residence_status, :action_status

  def initialize(id)
    @id = id
    #@residence_status = Redis0.get(id)
    #@action_status = Redis0.get(id)
  end

  # resident status
  #def resident?
  #  @residence_status
  #end

end