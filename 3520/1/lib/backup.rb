require 'fileutils'
require 'yaml'

module Backup
  def self.backup_check(rg_links)
    backup_names = rg_links.gems_name.each { |b_name| b_name.insert(-1, '.yml') }.sort
    backup_files = Dir['./yaml/tmp/*.yml'].each { |b_file| b_file.slice!('./yaml/tmp/') }.sort
    backup_names == backup_files if backup_dir_check
  end

  def self.backup_dir_check
    Dir.exist?('./yaml/tmp')
  end

  def self.backup_file_check(filename)
    backup_dir_check && File.exist?(backup_path(filename))
  end

  def self.backup_path(gem_name)
    "./yaml/tmp/#{gem_name}.yml"
  end

  def self.backup_create(gem_info)
    if backup_dir_check
      File.write(backup_path(gem_info[:name]), gem_info.to_yaml)
    else
      Dir.mkdir('./yaml/tmp') unless Dir.exist?('./yaml/tmp')
      backup_create(gem_info)
    end
  end

  def self.backup_load(filename)
    return YAML.safe_load(File.read(backup_path(filename)), [Symbol]) if backup_file_check(filename)

    raise 'smth wrong with backup'
  end

  def self.delete_backup
    FileUtils.rm_r './yaml/tmp' if backup_dir_check
  end
end
