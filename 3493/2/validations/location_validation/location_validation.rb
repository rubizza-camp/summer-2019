module LocationValidation
  def location?
    minsk_camp?(payload['location']) if payload['location']
  end

  private

  def minsk_camp?(location)
    (53.914264..53.916233).cover?(location['latitude'].to_f) &&
      (27.565941..27.571306).cover?(location['longitude'].to_f)
  end
end
