class StrongParameters
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def permit(*fields)
    parameters = {}
    fields.each do |field|
      parameters.merge! params.slice(field)
    end
    parameters
  end
end
