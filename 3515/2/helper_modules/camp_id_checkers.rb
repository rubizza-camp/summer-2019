module CampIdCheckers
  def self.check_camp_id_in_yaml(path, id)
    YAML.load_file(path)['id'].include?(id.to_i)
  end

  def self.check_camp_already_defined(id)
    User.all.select { |user| user.camp_id == id }.empty?
  end
end
