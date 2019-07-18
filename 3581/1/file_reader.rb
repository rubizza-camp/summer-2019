require 'yaml'
require_relative 'command_line_parser.rb'
require_relative 'github_repo_searcher.rb'

class FileReader
  def read_yml_file(hash_names, file_name)
    list_gems = YAML.load_file(file_name)
    check_empty(list_gems)
    list_gems['gems'].each do |name_of_gem|
      hash_names << name_of_gem
    end
  end

  private

  def check_empty(list_gems)
    true unless list_gems.empty?
  end
end
