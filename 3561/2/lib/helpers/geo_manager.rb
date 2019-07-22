class GeoManager
  def self.in_camp?(location)
    (53.914264..53.916233).include?(location['latitude'].to_f) &&
      (27.565941..27.571306).include?(location['longitude'].to_f)
    true
  end

  def self.save_geo(location, photo_new_path)
    FileManager.write_txt(photo_new_path, location)
  end
end
