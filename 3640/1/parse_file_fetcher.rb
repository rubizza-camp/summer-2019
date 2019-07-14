class ParseFileFetcher
  def self.get_all_names(name_file)
    gems = File.read(name_file).split("\n  - ")
    gems.delete_at(0)
    gems
  end
end
