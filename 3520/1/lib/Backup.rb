require 'fileutils'
require 'yaml'

module Backup
  def self.backup_check(rg_links)
    if backup_dir_check
      Dir["./yaml/tmp/*.yml"].each { |s| s.slice!('./yaml/tmp/') }.sort == rg_links
    end
  end

  def self.backup_dir_check
      Dir.exist?('./yaml/tmp')
  end

  def self.backup_path_regexp(gem_name)
    "./yaml/tmp/#{gem_name}.yml"
  end

  def self.backup_create(gem_name, gem_info)
    if backup_dir_check
      File.write(backup_path_regexp(gem_name), gem_info.to_yaml) # unless File.exist?(backup_path_regexp(gem_info))
    else
      Dir.mkdir('./yaml/tmp') unless Dir.exist?('./yaml/tmp')
      backup_create(gem_name, gem_info)
    end
  end

  def self.backup_load(filename)
    if backup_dir_check && File.exist?(backup_path_regexp(filename))
      YAML.load File.read backup_path_regexp(filename)
    else
      raise 'smth wrong with backup'
    end
  end

  def self.delete_backup
    FileUtils.rm_r './yaml/tmp' if backup_dir_check
  end
end
