module LocationValidation
  LATITUDE_RANGE = (53.914264..53.916233)
  LONGITUDE_RANGE = (27.565941..27.571306)

  def location?
    minsk_camp?(payload['location']) if payload['location']
  end

  private

  def minsk_camp?(location)
    LATITUDE_RANGE.cover?(location['latitude'].to_f) &&
    LONGITUDE_RANGE.cover?(location['longitude'].to_f)
  end
end
