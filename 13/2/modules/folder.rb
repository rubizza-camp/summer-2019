# frozen_string_literal: true

#creates directory
module Folder
  def self.create(dirname, path_to_file)
    folder = File.dirname(path_to_file)
    FileUtils.mkdir_p(folder) unless File.directory?(folder)
  end
end
