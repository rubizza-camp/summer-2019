class ParseFileFetcher
  def self.fetch_all_names(name_file)
    gems = File.read(name_file).strip.split("\n  - ")
    gems.delete_at(0)
    gems
  end
end
