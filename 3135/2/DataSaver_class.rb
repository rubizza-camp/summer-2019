class DataSaver
  def initialize(tg_id)
    @id = tg_id
  end

  # -camp number
  def camp_num(num_as_str)
    R.set("tgid_#{@id}_camp_num", num_as_str)
  end

  # -photo uri
  def photo_uri(uri)
    R.set("tgid_#{@id}_photo_uri", uri)
  end

  # -location
  def location(lat_as_str,long_as_str)
    R.set("tgid_#{@id}_location", "lat: #{lat_as_str}, long: #{long_as_str}")
  end
end
